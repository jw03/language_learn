class StreamsController < ApplicationController

  def host
  	@opentok= OpenTok::OpenTok.new(ENV["API_KEY"], ENV["API_SECRET"])
    sessionId = @opentok.create_session.session_id
    url = "/vidchat/#{sessionId}"
    redirect_to url
  end

  def join
  	@opentok= OpenTok::OpenTok.new(ENV["API_KEY"], ENV["API_SECRET"])
    session_id = params[:session_id]
    token = @opentok.generate_token(session_id)
    api_key = ENV["API_KEY"]

    render :video, :locals => {
      :api_key => api_key,
      :session_id => session_id,
      :token => token
    }
  end
  
end
