class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.integer :expense
      t.string :address_first_line
      t.string :city
      t.string :post_code
      t.string :phone_number
      t.timestamps
    end
  end
end
