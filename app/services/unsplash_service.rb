class UnsplashService
  include HTTParty
  base_uri "https://api.unsplash.com"

  def initialize
    @headers = {
      "Authorization" => "Client-ID #{Rails.application.credentials.unsplash[:access_key]}"
    }
  end

  def fetch_photos(query, per_page = 10)
    self.class.get("/search/photos", headers: @headers, query: { query: query, per_page: per_page })
  end
end
