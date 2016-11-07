class StreamsController < ApplicationController

  def host
    render :index
  end

  def room
  	apiKey = ENV["API_KEY"]
  	@opentok= OpenTok::OpenTok.new(apiKey, ENV["API_SECRET"])
  	rid = params[:rid]
  	@stream = Stream.find_by(rid: rid)
  	if @stream 
  		sid = @stream.sid
  		token = @opentok.generate_token(sid)
  	else
  		router = @opentok.create_session :archive_mode => :always,:media_mode => :routed
  		sid = router.session_id
  		@stream = Stream.new(rid: rid,sid: sid)
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

  def archive
  	session_id = params[:session_id]
  	archive = opentok.archives.create(session_id)
  end


  
end
