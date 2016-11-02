class UserTeachLanguage < ApplicationRecord
	belongs_to :user
	belongs_to :teach_language
end
