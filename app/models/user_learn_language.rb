class UserLearnLanguage < ApplicationRecord
	belongs_to :user
	belongs_to :learn_language
end
