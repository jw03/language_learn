class LearnLanguage < ApplicationRecord
has_many :users, through: :user_learn_languages
has_many :user_learn_languages
end
