class Ad < ActiveRecord::Base
  attr_accessible :description, :image, :price, :title,:category_id
  belongs_to :user
  belongs_to :category
  # TODO: cambiar el tipo de dato de :price a un string, para que el usuario pueda escribir 15/mes o algo asi

  has_many :images

  def Ad.search(query)

    return Ad.where("#{:title} LIKE '%#{query}%' OR #{:description} LIKE '%#{query}%'")

  end

end
