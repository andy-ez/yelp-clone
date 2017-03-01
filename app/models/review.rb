class Review < ActiveRecord::Base
  default_scope { order(created_at: :desc) }
  belongs_to :business
  belongs_to :user
  validates_presence_of :rating, :body
  validates_numericality_of :rating, less_than: 6, greater_than: 0, only_integer: true
  validates_uniqueness_of :business_id, scope: :user_id, message: "You have already submitted a review for this business"
end