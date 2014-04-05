class RemoveEmbeddedUrlInPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :embedded_url
  end
end
