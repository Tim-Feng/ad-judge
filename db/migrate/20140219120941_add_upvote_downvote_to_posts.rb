class AddUpvoteDownvoteToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :up_votes, :integer
    add_column :posts, :down_votes, :integer
  end
end
