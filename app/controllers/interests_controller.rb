class InterestsController < ApplicationController

	after_filter :user_activity

private

def user_activity
  current_user.try :touch
end


end
