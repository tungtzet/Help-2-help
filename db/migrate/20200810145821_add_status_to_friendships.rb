class AddStatusToFriendships < ActiveRecord::Migration[6.0]
  def change
    add_column :friendships, :status, :string, default: "pending"
  end
end
