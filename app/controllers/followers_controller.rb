class FollowersController < ApplicationController
  def index # a user sees all his followers
    @followers = FollowersUser.where(follower_id: current_user.id)
  end

  def create # a user follows another
    @followee = FollowersUser.create(follower_users_params)
    if @followee.save
      redirect_to user_followers_path, notice: "Suivi!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy # unfollow another user 
    # find the follower
    @followee = FollowersUser.find(params[:user_id])
    # then destroy (unfollow)
    if @follower.destroy
      redirect_to user_followers_path, notice: "Vous ne suivez plus cet utilisateur"
    else
      redirect_to user_followers_path, alert: "Impossible de ne plus suivre l'utilisateur"
    end
  end

  private

  def follower_users_params
    params.require(:followers_user).permit(:user_id, :follower_id)
  end
end
