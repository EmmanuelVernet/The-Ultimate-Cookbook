class TagsController < ApplicationController
  # only: [:index, :show, :create, :update, :destroy]
  
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.create(tag_params)
    if @tag.save
      redirect_to tags_path, notice: "Tag created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(tag_params)
    redirect_to tag_path(@tag)
    # TO DO => add safe guard for update with if statement
  end

  def destroy #allows to remove a tag from a recipe
    # find the tag item
    @tag = Tag.find(params[:id])
    # then destroy
    @tag.destroy
    redirect_to tag_path, notice: "Tag deleted"
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
