require 'net/http'
require 'json'

class MunisController < ApplicationController
  def index
    render :index, formats: [:html]
  end

  def show
    muni = Muni.find_or_create_by(route_name: params[:route_name])
    report = muni.reports.build(smell_rating: params[:smell_rating], clean_rating: params[:clean_rating],
                                driver_rating: params[:driver_rating])
    unless report.save
      flash[:danger] = 'Invalid ratings. Each must be a number from 1 to 5.'
      redirect_back_or_to(root_path)
      return
    end
    muni.update_averages
    report.create_story(content: params[:comment]) if params[:comment].present?
    if muni.save
      @munis = Muni.sorted_munis
      render :show
    else
      flash[:danger] = 'Something went wrong. Try again'
      redirect_back_or_to(root_path)
    end
  end

  def vehicles
    uri = URI("https://api.511.org/transit/VehiclePositions?api_key=#{ENV.fetch('MUNI_511_API_KEY',
                                                                                nil)}&agency=SF&format=json")
    response = Net::HTTP.get(uri).b.sub(/\A\xEF\xBB\xBF/n, '').force_encoding('UTF-8')
    data = JSON.parse(response)

    items = data['Entities'].filter_map do |entity|
      v = entity['Vehicle']
      next unless v && v['Trip'] && v['Position']

      {
        route_id: v['Trip']['RouteId'],
        latitude: v['Position']['Latitude'],
        longitude: v['Position']['Longitude']
      }
    end

    render json: { items: items }
  rescue StandardError => e
    Rails.logger.error "511 API error: #{e.message}"
    render json: { error: e.message }, status: :internal_server_error
  end

  def average
    muni = Muni.find_by(route_name: params[:route_name])
    render json: muni
  end
end
