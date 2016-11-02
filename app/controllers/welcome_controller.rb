require 'opentok'

class WelcomeController < ApplicationController
  def index
  end

  def video
  	api_key = '45711342'
  	@opentok= OpenTok::OpenTok.new('45711342', '54525e65d49550a0df0d750a22c915cfbd5260c0')
  	session_id = @opentok.create_session.session_id
  	token = @opentok.generate_token(session_id)
  	render :video,:locals => {
      :api_key => api_key,
      :session_id => session_id,
      :token => token
   }
  end
end
