class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.string :embedded_url
      t.string :slug
      t.string :favicon_url
      t.string :author_name
      t.string :author_url
      t.string :provider_name
      t.string :provider_url
      t.string :thumbnail_url
      t.string :thumbnail_width
      t.string :thumbnail_height
      t.string :width
      t.string :height
      t.text :description
      t.integer :user_id
      t.timestamps
    end
  end
end
