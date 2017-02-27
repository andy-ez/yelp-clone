class AddDescriptionToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :description, :string
  end
end
