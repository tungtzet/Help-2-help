class UserDisease < ApplicationRecord
  belongs_to :profile
  belongs_to :disease
end
