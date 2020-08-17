class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  has_many_attached :photos
end
