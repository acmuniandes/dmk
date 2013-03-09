class AddUserIdToAds < ActiveRecord::Migration
  def change
    add_column :ads, :user_id, :integer
  end
end
