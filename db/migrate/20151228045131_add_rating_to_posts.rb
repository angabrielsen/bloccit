class AddRatingToPosts < ActiveRecord::Migration
  def change
  	add_reference :posts, :rating, index: true
    add_column :posts, :rating, :integer
  end
end
