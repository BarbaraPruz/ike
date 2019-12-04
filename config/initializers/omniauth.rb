Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], 
  #   scope: "user:email,user:follow"
  # provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], 
    { client_options: { ssl: { ca_file: Rails.root.join('cacert.pem').to_s } } }
end
