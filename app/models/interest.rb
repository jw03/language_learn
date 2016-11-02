class Interest < ApplicationRecord
	has_many :users, through: :user_interests
	has_many :user_interests
end
