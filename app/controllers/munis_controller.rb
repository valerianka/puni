require 'net/http'
require 'json'

class MunisController < ApplicationController

  def index
    render :index, formats: [:html]
  end

  def show
    muni = Muni.find_by(route_name: params[:route_name]) || Muni.create(route_name: params[:route_name])
    report = muni.reports.create(smell_rating: params[:smell_rating], clean_rating: params[:clean_rating], driver_rating: params[:driver_rating])
    muni.update_averages
    report.create_story(content: params[:comment]) if !params[:comment].blank?
    if muni.save then
      @munis = Muni.sorted_munis
      render :show
    else
      flash.now[:danger] = "Something went wrong. Try again"
      redirect_back fallback_location: root_path
    end
  end

  def vehicles
    uri = URI("https://api.511.org/transit/VehiclePositions?api_key=#{ENV['MUNI_511_API_KEY']}&agency=SF&format=json")
    response = Net::HTTP.get(uri).encode('UTF-8', invalid: :replace, undef: :replace).gsub("\xEF\xBB\xBF", '')
    data = JSON.parse(response)

    items = data['Entities'].filter_map do |entity|
      v = entity['Vehicle']
      next unless v && v['Trip'] && v['Position']
      {
        route_id:  v['Trip']['RouteId'],
        latitude:  v['Position']['Latitude'],
        longitude: v['Position']['Longitude']
      }
    end

    render json: { items: items }
  rescue => e
    Rails.logger.error "511 API error: #{e.message}"
    render json: { error: e.message }, status: 500
  end

  def average
    muni = Muni.find_by(route_name: params[:route_name])
    render json: muni
  end
end
