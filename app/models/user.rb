class User < ApplicationRecord
  include Clearance::User

  mount_uploaders :avatars, AvatarUploader
  
  validates_presence_of :email, message: "can't be blank!"

  has_many :authentications, :dependent => :destroy

  has_many :interests, through: :user_interests
  has_many :user_interests

  has_many :teach_languages, through: :user_teach_languages
  has_many :user_teach_languages

  has_many :learn_languages, through: :user_learn_languages
  has_many :user_learn_languages



  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.first_name = auth_hash["info"]["first_name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.password = SecureRandom.hex(6)
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end


end
