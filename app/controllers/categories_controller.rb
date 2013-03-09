class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id]) ;
    @ads = Ad.find_all_by_category_id(@category.id)
  end
end
