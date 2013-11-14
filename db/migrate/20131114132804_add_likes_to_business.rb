class AddLikesToBusiness < ActiveRecord::Migration
  def change
  	add_column :businesses, :fb_likes, :integer
  end
end
