class Disease < ApplicationRecord
  has_many :user_diseases
  has_many :profiles, through: :user_diseases

  validates :name, presence: true
end
