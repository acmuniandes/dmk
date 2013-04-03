class Ad < ActiveRecord::Base
  attr_accessible :description, :price, :title,:category_id
  belongs_to :user
  belongs_to :category
  # TODO: cambiar el tipo de dato de :price a un string, para que el usuario pueda escribir 15/mes o algo asi

  has_many :images

  def Ad.search(query)

    return Ad.where("#{:title} LIKE '%#{query}%' OR #{:description} LIKE '%#{query}%'").order(:created_at.to_s << " DESC")

  end

  def image
    num_images = images.size
    if num_images > 0
      "/"+images.first.url
    else
      "http://placehold.it/400x400"
    end
  end

  def Ad.all
    order(:created_at.to_s << " DESC")
  end

end
