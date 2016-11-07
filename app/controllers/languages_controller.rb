class LanguagesController < ApplicationController
  def learn
  	@learn_languages = params["learn"]["languages"]
  	@learn_languages.each do |x|
  		language = LearnLanguage.find_by(name:x)
	  		if language.nil?
	  			b = LearnLanguage.create(name:x)
	  			b.users << current_user
	  		else
	  			language.users << current_user
	  		end
	  		@user = current_user
	  		@learn_languages = current_user.learn_languages
	  		 	@user_interest = current_user.interests
	  		 	@interests = Interest.all
	  		redirect_to @user, notice: 'User was successfully updated.'
  	end
  end
end
