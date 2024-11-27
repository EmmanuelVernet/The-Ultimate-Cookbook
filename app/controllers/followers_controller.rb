class FollowersController < ApplicationController
  def index # a user sees all his followers
    @followers = FollowersUser.all
  end

  def create # a user follows another
    @followee = FollowersUser.create(follower_users_params)
    @followee.save
  end

  def destroy # unfollow another user 
    # find the follower
    @followee = FollowersUser.find(params[:user_id])
    # then destroy (unfollow)
    @follower.destroy
    redirect_to user_followers_path, notice: "Unfollowed"
  end

  private

  def follower_users_params
    params.require(:user_id).permit(:follower_id)
  end
end
