class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :description
      t.string :image
      t.float :price
      t.string :title
      t.integer :category_id

      t.timestamps
    end
  end
end
