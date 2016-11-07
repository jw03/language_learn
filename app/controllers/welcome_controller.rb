require 'opentok'

class WelcomeController < ApplicationController
  def index

  	if signed_in?
	  	@languages = Language.all
	  	@interests = Interest.all
	  	@user = current_user
	  	@teach_languages = current_user.teach_languages.all
	  	@learn_languages = current_user.learn_languages.all
	  	@user_interest = current_user.interests.all
      @chats_available = Chat.all.where.not(chat_session: nil)
	  else
	  end
  end

end
