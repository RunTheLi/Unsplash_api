class StaticPagesController < ApplicationController
  def home
    if params[:query].present?
      service = UnsplashService.new
      response = service.fetch_photos(params[:query])

      if response.success?
        @photo = response.parsed_response["results"]
      else
        @error = "failed to fetch photos. Please try again"
        @photo = []
      end
    else
      @photo = []
    end
  end
end
