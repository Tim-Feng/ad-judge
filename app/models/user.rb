class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :user_name, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  sluggable_column :user_name

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.user_name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.password = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.email = auth.info.email
      user.image_url = auth.info.image
      user.save!
    end
  end

  def admin?
    self.role == "admin"
  end

  def moderator?
    self.role == "moderator"
  end
end