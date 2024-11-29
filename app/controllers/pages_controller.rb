class PagesController < ApplicationController
  def home
    @recipes = Recipe.all
  end

  def index

  end



end
