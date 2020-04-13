class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true 
  validates :condition, presence: true 
  
  
  
end
