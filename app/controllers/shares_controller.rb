class SharesController < ApplicationController
# methode create => qui prend une recipes + un receiver_id a selectionner
# # => creer un record "Share"
# # associations => has_many received_recipes through shares, source: :recipe

  # before_action :set_recipe, only: [:index, :create]
  before_action :authenticate_user!


  def index
    @user_shares = Share.where(user_id: current_user.id)
    @received_shares = Share.where(receiver_id: current_user.id)
    @followers = current_user.followers
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @share = Share.new

    # # Fetch unique followers and followees => from GPT
    # follower_ids = current_user.followers.pluck(:id) || []
    # followee_ids = current_user.followees.pluck(:id) || []

    # @possible_receivers = User.where(id: (follower_ids + followee_ids).uniq)
  end

  def create
    @share = Share.create(share_params)
    @share.user = current_user

    # # Validate receiver => from GPT
    # follower_ids = current_user.followers.pluck(:id) || []
    # followee_ids = current_user.followees.pluck(:id) || []
    # valid_receiver_ids = (follower_ids + followee_ids).uniq

    if @share.save
      redirect_to recipes_path, notice: "Recette partagée!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # def set_recipe
  #   @recipe = Recipe.find(params[:recipe_id])
  # end

  # Set the specific share
  # def set_share
  #   @share = Share.find(params[:id])
  # end

  def share_params
    params.require(:share).permit(:user_id, :recipe_id, :message, :receiver_id)
  end
end
