class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :ads

  def Category.get_top(num)

    return Category.find_by_sql("
      SELECT c.* FROM
          categories c
        join
          (SELECT COUNT(*) as count,category_id FROM ads GROUP BY category_id ORDER BY count DESC) top
        WHERE
          c.id = top.category_id
        LIMIT #{num}
                                ")

  end

  def Category.get_by_name
    return Category.all(:order=>:name)
  end
end
