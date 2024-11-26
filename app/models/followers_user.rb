class FollowersUser < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: "User"
end

# fofo = FollowersUser.new(user: User.first, follower: User.last)
# fofo.user => instance de User
# fofo.follower => instance de User
