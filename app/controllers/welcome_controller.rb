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
	  else
	  end

	  if @learn_languages == nil or @learn_languages.count == 0
	  else
	  @learn = current_user.learn_languages.first.name
	  	a = TeachLanguage.find_by(name: @learn)
	  	unless a.nil?
		  	a.users.each do |x|
		  		@users = []
		  		if x.online?
		  			@users << x 
		  		end
		  	end
	  	end
	  end

  end

end
