class SharesController < ApplicationController
# methode create => qui prend une recipes + un receiver_id a selectionner
# # => creer un record "Share"
# # associations => has_many received_recipes through shares, source: :recipe
# 
# INDEX 
# Show all shares for a specific recipe or for the current user if required.
# CREATE
# Allow a user to share a recipe with another user by creating a Share.
# DESTROY
# Allow the sender to delete a share (if needed).
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
  end

  def create
    @share = Share.create(share_params)
    @share.user = current_user
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
