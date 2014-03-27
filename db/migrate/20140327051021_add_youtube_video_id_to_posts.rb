class AddYoutubeVideoIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :youtube_video_id, :string
  end
end
