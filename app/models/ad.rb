class Ad < ActiveRecord::Base
  attr_accessible :description, :image, :price, :title,:category_id
  belongs_to :user
  belongs_to :category
end
