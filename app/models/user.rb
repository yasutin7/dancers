class User < ApplicationRecord
  has_secure_password
  validates :name, {presence: true,  length: { maximum: 30 }}
  validates :email, presence: true
  validates :password_digest, presence: true
  validates :introduce, length: { maximum: 300 }
  has_many :posts , dependent: :destroy
  mount_uploader :image, ImageUploader 
  scope :recent, -> { order(created_at: :desc)}

end
