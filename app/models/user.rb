class User < ApplicationRecord
  has_secure_password
  validates :name, {presence: true,  length: { maximum: 30 }}
  validates :email, presence: true
  validates :password_digest, presence: true
  validates :introduce, length: { maximum: 300 }
  has_many :posts , dependent: :destroy
  mount_uploader :image, ImageUploader 
  scope :recent, -> { order(created_at: :desc)}
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  has_many :following, through: :active_relationships, source:  'followed' 
  has_many :followers, through: :passive_relationships,  source: 'follower'

  

  def follow(other_user)
     active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
     active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def  current_user?(user)
    current_user.id == user.id
  end

 
  
end
