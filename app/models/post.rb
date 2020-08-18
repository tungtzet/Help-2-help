class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  has_many :likes, dependent: :destroy
  validates :title, :content, presence: true
end
