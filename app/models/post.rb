class Post < ActiveRecord::Base
  include Sluggable
  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :votes, as: :voteable

  validates :url, presence: true, uniqueness: true
  
  sluggable_column :title

  after_create :update_from_embedly

  def update_from_embedly
    
    post = self
 
    urls = [url]

    embedly_api = Embedly::API.new(:key => Settings.embedly.key)
    embedly_objs = embedly_api.oembed(:urls => urls)
    embedly_obj = embedly_objs[0]
 
    response_data = embedly_obj.marshal_dump
 
    
    post.title             =  response_data[:title]
    post.description       =  response_data[:description]
    post.url               =  response_data[:url]
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
    post.save
  end

end