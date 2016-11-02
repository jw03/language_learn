class TeachLanguage < ApplicationRecord
has_many :users, through: :user_teach_languages
has_many :user_teach_languages
end
