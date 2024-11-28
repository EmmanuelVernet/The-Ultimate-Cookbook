class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # FOR USER COOKBOOK
  has_many :recipes

  # FOLLOWERS
  has_many :followers_users, class_name: "FollowersUser", foreign_key: :user, dependent: :destroy
  has_many :followers, through: :followers_users, source: :user
  # FOLLOWEES
  has_many :followees_users, class_name: "FollowersUser", foreign_key: :follower
  has_many :followees, through: :followees_users, source: :follower

  # user shares
  has_many :user_shares, class_name: "Share", foreign_key: :user_id
  has_many :shared_recipes, through: :user_shares, source: :recipe

  # receiver shares
  has_many :receiver_shares, class_name: "Share", foreign_key: :receiver_id
  has_many :received_recipes, through: :receiver_shares, source: :recipe
end

# current_user.followees => renvoie un array de Users que current user follow
# current_user.followers => renvoie un array de Users qui followent current_user