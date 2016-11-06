class AdminController < ApplicationController
  def index
  	@chats = Chat.all
  	@learn = LearnLanguages.all
  	@teach = TeachLanguages.all
  end
end
