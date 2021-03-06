class User < ActiveRecord::Base
  has_many :reviews, -> { order('created_at DESC') }
  has_secure_password
  validates_presence_of :first_name, :last_name, :email, :post_code, :city
  validates_uniqueness_of :email, case_sensitive: false
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of :email, with: VALID_EMAIL_REGEX
  before_save { self.email = self.email.downcase if self.email }

  def profile_picture
    avatar.blank? ? "avatar.png" : avatar
  end

  def thumbnail
    thumb.blank? ? profile_picture : thumb
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def can_write_review?(business)
    !reviews.map(&:business_id).include?(business.id)
  end
end