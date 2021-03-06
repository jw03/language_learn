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
      @stream = Stream.new(rid: rid,sid: sid, host_id: params[:host])
      @stream.save!
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
    gid = params[:guest]
    start= params[:start]
    rid = params[:rid]
    apiKey = ENV["API_KEY"]
    @opentok= OpenTok::OpenTok.new(apiKey, ENV["API_SECRET"])
    @stream = Stream.find_by(rid: rid)
      sid = @stream.sid
      @stream.update(guest_id: gid, time_start: start)
      token = @opentok.generate_token(sid)
    render :room, :locals => {
      :apiKey => apiKey,
      :sid => sid,
      :rid => rid,
      :token => token
    }
  end


  def summary
  	rid = params[:rid]
  	@stream = Stream.find_by(rid: rid)
    if @stream.guest_id == nil
      render :summary
    else
      if @stream.amount == nil
    	@stream.update(time_end: Time.now)
    	@stream.save!
    	@duration = (Time.strptime(@stream.time_end,  '%Y-%m-%d %H:%M:%S %z')) - (Time.strptime(@stream.time_start,  '%Y-%m-%d %H:%M:%S %z'))
    	@amount = @duration.seconds
      @stream.update(amount: @amount)
      @stream.save!
    	@earner = User.find(@stream.host_id)
    	@spender = User.find(@stream.guest_id)
    	@earner.update(total_coins: (@earner.total_coins+@amount))
      @earner.save!
    	@spender.update(total_coins: (@spender.total_coins-@amount))
      @spender.save!
      end
      @earner = User.find(@stream.host_id)
      @spender = User.find(@stream.guest_id)
      @amount = @stream.amount
      @duration = @amount
  	render :summary
    end
  end
  
end
