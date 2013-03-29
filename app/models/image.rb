class Image < ActiveRecord::Base
  attr_accessible :title, :url, :ad_id
  belongs_to :ad
end
