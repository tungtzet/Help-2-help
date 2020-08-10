class Friendship < ApplicationRecord
  belongs_to :asker, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :status, inclusion: { in: ["accepted", "rejected", "pending"] }
end
