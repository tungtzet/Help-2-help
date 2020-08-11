class Profile < ApplicationRecord
  belongs_to :user
  has_many :user_diseases
  has_many :diseases, through: :user_diseases
  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  
  validates :name, presence: true
end
