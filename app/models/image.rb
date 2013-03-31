class Image < ActiveRecord::Base
  attr_accessible :title, :url, :ad_id
  belongs_to :ad

  def url
    if self.url
      self.url
    else
      "http://placehold.it/400x400"
    end
  end

end
