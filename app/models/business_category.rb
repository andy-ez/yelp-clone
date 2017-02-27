class BusinessCategory < ActiveRecord::Base
  belongs_to :business
  belongs_to :category
  validates_uniqueness_of :business_id, scope: :category_id
end