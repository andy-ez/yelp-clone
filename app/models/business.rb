class Business < ActiveRecord::Base
  has_many :reviews, -> { order('created_at DESC') }
  default_scope { order(created_at: :desc) }
  has_many :business_categories
  has_many :categories, through: :business_categories
  validates_presence_of :name, :description, :phone_number, :address_first_line, :city, :post_code, :expense
  validates_numericality_of :expense, greater_than: 0, less_than: 5, only_integer: true

  def rating
    return 0 unless reviews.any?
    avg =  reviews.map(&:rating).reduce(&:+) / reviews.count.to_f
    to_nearest_half(avg)
  end

  private

  def to_nearest_half(num)
    ( num * 2 ).round / 2.0
  end
end