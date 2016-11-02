require 'opentok'

class WelcomeController < ApplicationController
  def index
  end

  def video
  	session_id = opentok.create_session.session_id
  	token = OpenTok::OpenTok.new('45711342', '54525e65d49550a0df0d750a22c915cfbd5260c0').generate_token(session_id)
  	render :video,  :locals => {
      :session_id => session_id,
      :token => token
    }
  end
end
