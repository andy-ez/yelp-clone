class AddThumbToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :thumb, :string
  end
end
