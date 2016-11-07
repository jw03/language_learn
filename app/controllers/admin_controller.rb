class AdminController < ApplicationController
  def index
  	@chats = Chat.all
  end
end
