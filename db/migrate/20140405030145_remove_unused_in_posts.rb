class RemoveUnusedInPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :favicon_url
    remove_column :posts, :author_name
    remove_column :posts, :author_url
    remove_column :posts, :provider_name
    remove_column :posts, :provider_url
    remove_column :posts, :thumbnail_url
    remove_column :posts, :thumbnail_width
    remove_column :posts, :thumbnail_height
    # remove_column :posts, :html
    remove_column :posts, :width
    remove_column :posts, :height
  end
end
