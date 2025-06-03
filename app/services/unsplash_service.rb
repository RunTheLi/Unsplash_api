class UnsplashService
  include HTTParty
  base_uri "https://api.unsplash.com"

  def initialize
    @access_key = Rails.application.credentials.unsplash[:access_key]
  end

  def fetch_photos(query)
    self.class.get("/search/photos", query: { query: query, client_id: @access_key, per_page: 12 })
  end

  def fetch_user_photos(username)
    self.class.get("/users/#{username}/photos", query: { client_id: @access_key, per_page: 12 })
  end
end
