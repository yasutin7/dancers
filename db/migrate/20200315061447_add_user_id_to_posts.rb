class AddUserIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :user, null: false, index: true
  end
end
