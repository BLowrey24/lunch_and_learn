class Api::V1::FavoritesController < ApplicationController
  def index
    user = User.find_by(api_key: params[:api_key])
    if user.present?
      favorites = user.favorites
      render json: FavoriteSerializer.new(favorites), status: :ok
    else
      render json: { error: "Invalid API key" }, status: 400
    end
  end

  def create
    user = User.find_by(api_key: params[:api_key])
    if user.present?
      favorite = Favorite.create(favorite_params.merge(user_id: user.id))
      if favorite.save
        render json: { success: "Favorite added successfully" }, status: :created
      end
    else
      render json: { error: "Unauthorized request" }, status: :bad_request
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:country, :recipe_link, :recipe_title)
  end
end
