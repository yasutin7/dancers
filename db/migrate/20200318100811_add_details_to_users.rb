class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :integer
    add_column :users, :sex, :string
    add_column :users, :genre, :string
    add_column :users, :introduce, :text
    add_column :users, :address, :text
  end
end
