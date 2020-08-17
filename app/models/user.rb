class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :user_chats, dependent: :destroy
  has_many :chats, through: :user_chats
  has_many :friendships_as_asker, class_name: "Friendship", source: :friendships, foreign_key: :asker_id, dependent: :destroy
  has_many :friendships_as_receiver, class_name: "Friendship", source: :friendships, foreign_key: :receiver_id, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def is_friend_with?(another_user)
    friendship = Friendship.find_by(asker: self, receiver: another_user) || Friendship.find_by(receiver: self, asker: another_user)
    return friendship && friendship.status == "accepted"    
  end
end
