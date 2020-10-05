class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :condition, presence: true
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  def like_user(id)
    likes.find_by(user_id: id)
  end
end
