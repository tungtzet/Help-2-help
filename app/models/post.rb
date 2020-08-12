class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  validates :title, :content, presence: true
end
