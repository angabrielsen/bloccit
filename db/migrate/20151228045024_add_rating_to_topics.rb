class AddRatingToTopics < ActiveRecord::Migration
  def change
  	add_reference :topics, :rating, index: true
    add_column :topics, :rating, :integer
  end
end
