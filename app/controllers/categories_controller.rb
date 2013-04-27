class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:name)
  end

  def show
    @category = Category.find(params[:id]) ;
    @ads = Ad.get_latest_in_category(@category.id, params[:page])
  end
end
