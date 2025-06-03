class PhotosController < ApplicationController
  def index
    service = UnsplashService.new
    response = service.fetch_photos(params[:query] || "nature")

    if response.success?
      render json: response.parsed_response["results"]
    else
      render json: { error: "Failed to fetch photos" }, status: :bad_request
    end
  end
end
