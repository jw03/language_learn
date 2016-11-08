class StreamsController < ApplicationController

  def host
  	rid = params[:rid]
  	apiKey = ENV["API_KEY"]
  	@opentok= OpenTok::OpenTok.new(apiKey, ENV["API_SECRET"])
  	@stream = Stream.find_by(rid: rid)
  	if @stream 
  		sid = @stream.sid
  		token = @opentok.generate_token(sid)
  	else
  		router = @opentok.create_session :archive_mode => :always,:media_mode => :routed
  		sid = router.session_id
  		token = @opentok.generate_token(sid)
  	end
    render :room, :locals => {
      :apiKey => apiKey,
      :sid => sid,
      :rid => rid,
      :token => token
    }
  end

  def guest
    hid = params[:host]
    gid = params[:guest]
    start= params[:start]
    rid = params[:rid]
    apiKey = ENV["API_KEY"]
    @opentok= OpenTok::OpenTok.new(apiKey, ENV["API_SECRET"])
    @stream = Stream.find_by(rid: rid)
      sid = @stream.sid
      @stream = Stream.new(rid: rid,sid: sid,host_id: hid, guest_id: gid, time_start: start)
      @stream.save!
      token = @opentok.generate_token(sid)
    render :room, :locals => {
      :apiKey => apiKey,
      :sid => sid,
      :rid => rid,
      :token => token
    }
  end


  def endstream
  	time_end = params[:time_end]
  	rid = params[:rid]
  	@stream = Stream.find_by(rid: rid)
  	@stream.update(time_end: time_end)
  	@stream.save!
  	@duration = (@stream.time_end - @stream.time_start)
  	@amount = @duration.min * 10
  	@earner = User.find_by(@stream.host_id)
  	@spender = User.find_by(@stream.guest_id)
  	@earner.update(total_coins: (@earner.total_coins+@amount))
  	@earner.save!
  	@spender.update(total_coins: (@spender.total_coins-@amount))
  	@spender.save!
  	render :summary_page
  end
  
end
