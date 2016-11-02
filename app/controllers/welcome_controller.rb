require 'opentok'

class WelcomeController < ApplicationController
  def index
  end

  def video
  	api_key = ENV["API_KEY"]
  	@opentok= OpenTok::OpenTok.new(ENV["API_KEY"], ENV["API_SECRET"])
  	session_id = @opentok.create_session.session_id
  	token = @opentok.generate_token(session_id)
  	render :video,:locals => {
      :api_key => api_key,
      :session_id => session_id,
      :token => token
   }
  end
end
