class Post < ActiveRecord::Base
  include Sluggable
  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :votes, as: :voteable

  before_validation :validate_youtube_link_and_video_id

  validates :url, presence: true, uniqueness: true
  validates :youtube_video_id, presence: true, uniqueness: true
  # validate :validate_youtube_link_and_video_id
  
  sluggable_column :title

  after_create :update_from_embedly

  def validate_youtube_link_and_video_id
    post = self
    post.youtube_video_id = youtube_validate(post.url)
  end

  def youtube_validate(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end
  end

  def update_from_embedly
    
    post = self
 
    urls = [url]

    embedly_api = Embedly::API.new(:key => Settings.embedly.key)
    embedly_objs = embedly_api.oembed(:urls => urls)
    embedly_obj = embedly_objs[0]
 
    response_data = embedly_obj.marshal_dump

    post.title            =  response_data[:title]
    post.description      =  response_data[:description]
    post.url              =  response_data[:url]
    post.youtube_video_id = youtube_validate(post.url)
    # post.favicon_url       =  response_data[:favicon_url]
    # post.author_name       =  response_data[:author_name]
    # post.author_url        =  response_data[:author_url]
    # post.provider_name     =  response_data[:provider_name]
    # post.provider_url      =  response_data[:provider_url]
    # post.thumbnail_url     =  response_data[:thumbnail_url]
    # post.thumbnail_width   =  response_data[:thumbnail_width]
    # post.thumbnail_height  =  response_data[:thumbnail_height]
    # post.embedded_url      =  response_data[:html]
    # post.width             =  response_data[:width]
    # post.height            =  response_data[:height]
 
    # post.save
  end

  
end