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

  # TODO: replace with 511.org API once API key is available:
  #   uri = URI("https://api.511.org/transit/VehiclePositions?api_key=#{ENV['MUNI_511_API_KEY']}&agency=SF&format=json")
  #   Map: entity.vehicle.position.{latitude,longitude}, entity.vehicle.trip.route_id
  MOCK_VEHICLES = [
    { route_id: '1',  latitude: 37.7879, longitude: -122.4075 },
    { route_id: '1',  latitude: 37.7883, longitude: -122.4210 },
    { route_id: '5',  latitude: 37.7804, longitude: -122.4637 },
    { route_id: '5',  latitude: 37.7801, longitude: -122.4490 },
    { route_id: '14', latitude: 37.7599, longitude: -122.4148 },
    { route_id: '14', latitude: 37.7615, longitude: -122.4280 },
    { route_id: '22', latitude: 37.7694, longitude: -122.4350 },
    { route_id: '22', latitude: 37.7810, longitude: -122.4352 },
    { route_id: '30', latitude: 37.7960, longitude: -122.4057 },
    { route_id: '30', latitude: 37.8009, longitude: -122.4098 },
    { route_id: '38', latitude: 37.7816, longitude: -122.4450 },
    { route_id: '38', latitude: 37.7820, longitude: -122.4700 },
    { route_id: '49', latitude: 37.7793, longitude: -122.4193 },
    { route_id: '49', latitude: 37.7500, longitude: -122.4190 },
    { route_id: 'J',  latitude: 37.7625, longitude: -122.4350 },
    { route_id: 'J',  latitude: 37.7502, longitude: -122.4330 },
    { route_id: 'L',  latitude: 37.7560, longitude: -122.4890 },
    { route_id: 'L',  latitude: 37.7558, longitude: -122.4650 },
    { route_id: 'N',  latitude: 37.7640, longitude: -122.4680 },
    { route_id: 'N',  latitude: 37.7785, longitude: -122.4056 },
  ].freeze

  def vehicles
    render json: { items: MOCK_VEHICLES }
  end

  def average
    muni = Muni.find_by(route_name: params[:route_name])
    render json: muni
  end
end
