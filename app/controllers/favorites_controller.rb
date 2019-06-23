class FavoritesController < ApplicationController
  # GET /favorites
  def index
    @favorites = current_user.favorites.includes(article: [:user])
    gon.jbuilder
  end
end
