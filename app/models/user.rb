class User < ApplicationRecord
  include Clearance::User

	has_many :interests, through: :user_interests
	has_many :user_interests

	has_many :teach_languages, through: :user_teach_languages
	has_many :user_teach_languages

	has_many :learn_languages, through: :user_learn_languages
	has_many :user_learn_languages

end
