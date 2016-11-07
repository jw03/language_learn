require 'opentok'

class WelcomeController < ApplicationController
  def index

  	if signed_in?
	  	@languages = Language.all
	  	@interests = Interest.all
	  	@user = current_user
	  	@learn_languages = current_user.learn_languages
	  	@user_interest = current_user.interests.all
	  else
	  end
  end

end
