class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  after_filter :user_activity

private

def user_activity
  current_user.try :touch
end

end
