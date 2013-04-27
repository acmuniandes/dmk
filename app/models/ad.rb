class Ad < ActiveRecord::Base
  attr_accessible :description, :price, :title,:category_id
  belongs_to :user
  belongs_to :category
  has_many :images

  self.per_page = 20

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

  def Ad.get_latest_in_category(category_id, page)
    where("category_id=#{category_id}").order('created_at DESC').page(page)
  end

end
