class AddDetailsToLikes < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :tweet_id, :integer
  end
end
