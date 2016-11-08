class AdminController < ApplicationController
  def index

  	@learn = LearnLanguage.all
  	@teach = TeachLanguage.all
  end
end
