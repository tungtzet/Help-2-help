class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :user_diseases, dependent: :destroy
  has_many :diseases, through: :user_diseases
  has_many :friendships_as_asker, class_name: "Friendship", source: :friendships, foreign_key: :asker_id, dependent: :destroy
  has_many :friendships_as_receiver, class_name: "Friendship", source: :friendships, foreign_key: :receiver_id, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
