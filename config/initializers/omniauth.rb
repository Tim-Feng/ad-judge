Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Settings.facebook.key, Settings.facebook.secret,
           :secure_image_url => true, :image_size => 'normal',
           :display => 'popup'
end