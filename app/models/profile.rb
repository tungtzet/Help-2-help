class Profile < ApplicationRecord
  belongs_to :user
  has_many :user_diseases
  has_many :diseases, through: :user_diseases
  has_one_attached :photo
  
  validates :name, presence: true
end
