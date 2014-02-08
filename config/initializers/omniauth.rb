Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
           :secure_image_url => true, :image_size => 'normal',
           :display => 'popup'
end