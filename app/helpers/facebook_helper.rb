module FacebookHelper
  def share_link(post)
    fb_key = ENV['FACEBOOK_KEY']
    href = <<-EOS
https://www.facebook.com/dialog/feed?app_id=#{fb_key}&display=page&link=http://www.ad-judge.com/posts/#{post.slug}&picture=http://img.youtube.com/vi/#{post.youtube_video_id}/hqdefault.jpg&name=#{post.title}&redirect_uri=#{request.original_url.gsub("/vote","")}
EOS
    URI::encode(href)
  end
end
