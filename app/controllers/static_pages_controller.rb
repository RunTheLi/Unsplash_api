class StaticPagesController < ApplicationController
  def home
    @photos = []
    @error = nil
    service = UnsplashService.new
    response = nil

    if params[:query].present?
      response = service.fetch_photos(params[:query])
      Rails.logger.debug "🔍 Search Query API Response: #{response.inspect}"

    elsif params[:username].present?
      response = service.fetch_user_photos(params[:username])
      Rails.logger.debug "👤 User Photos API Response: #{response.inspect}"
    end

    if response&.success?
      body = response.parsed_response
      Rails.logger.debug "📦 Parsed Response: #{body.inspect}"

      @photos = body["results"] || body
    elsif response
      @error = "Failed to fetch photos. API responded with status #{response.code}."
    end
  rescue => e
    Rails.logger.error "🔥 Exception in StaticPagesController#home: #{e.message}"
    @error = "Something went wrong: #{e.message}"
  end
end
