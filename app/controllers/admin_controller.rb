class AdminController < ApplicationController
  def index
  	@chats = Chat.all
  	@learn = LearnLanguage.all
  	@teach = TeachLanguage.all

  end
end
