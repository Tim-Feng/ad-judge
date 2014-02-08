class Post < ActiveRecord::Base
  include Sluggable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments

  validates :url, presence: true, uniqueness: true
  
  sluggable_column :title

    after_create :update_from_embedly

  def update_from_embedly
 
    link = self
 
    urls = [url]

    embedly_api = Embedly::API.new(:key => MySettings.embedly_key)
    embedly_objs = embedly_api.oembed(:urls => urls)
    embedly_obj = embedly_objs[0]
 
    response_data = embedly_obj.marshal_dump
 
    link.favicon_url       =  response_data[:favicon_url]
    link.title             =  response_data[:title]
    link.author_name       =  response_data[:author_name]
    link.author_url        =  response_data[:author_url]
    link.provider_name     =  response_data[:provider_name]
    link.provider_url      =  response_data[:provider_url]
    link.description       =  response_data[:description]
    link.thumbnail_url     =  response_data[:thumbnail_url]
    link.thumbnail_width   =  response_data[:thumbnail_width]
    link.thumbnail_height  =  response_data[:thumbnail_height]
    link.html              =  response_data[:html]
    link.url               =  response_data[:url]
    link.width             =  response_data[:width]
    link.height            =  response_data[:height]
    
 
    link.save
  end

end