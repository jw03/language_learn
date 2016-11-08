class User < ApplicationRecord
  include Clearance::User

  mount_uploaders :avatars, AvatarUploader

  has_many :payments
  has_many :authentications, :dependent => :destroy
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :teach_languages
  has_and_belongs_to_many :learn_languages

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :gender, presence: true
  # validates :age, numericality: { greater_than: 18, only_integer: true }

  # validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, presence: true


  def self.create_with_auth_and_hash(authentication,auth_hash)

    create! do |u|
      completename = auth_hash["info"]["name"]
      u.first_name = completename.split(" ").first
      u.last_name = completename.split(" ").last
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.gender = "unknown"
      u.age = 99999
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


def online?
  updated_at > 5.minutes.ago
end

end
