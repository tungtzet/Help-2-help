class Profile < ApplicationRecord
  attr_accessor :disease
  belongs_to :user
  has_many :user_diseases, dependent: :destroy
  has_many :diseases, through: :user_diseases
  has_one_attached :photo

  validates :name, presence: true
  # validates :disease, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :bio ],
    associated_against: {
      diseases: :name
    },
    using: {
      tsearch: { prefix: true }
    }
end
