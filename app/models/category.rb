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

  def Category.as_list
    @categories = []
    Category.all.each do |c|
      @categories.push c.name
    end
    return @categories
  end

  def Category.get_id(name)
    c =  Category.find_by_name(name);
    if c then
      return c.id;
    else
      c = Category.new(:name=>name);
      c.save;
      return c.id;
    end
  end

end
