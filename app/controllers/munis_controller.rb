class MunisController < ApplicationController

  def index
  end

  def show
    muni = Muni.find_by(route_name: params[:route_name]) || Muni.create(route_name: params[:route_name])
    muni.reports.create(smell_rating: params[:smell_rating], clean_rating: params[:clean_rating], driver_rating: params[:driver_rating])
    muni.update_averages
    if muni.save then
      @munis = Muni.sorted_munis
      render :show
    else 
      flash.now[:danger] = "Something went wrong. Try again"
      redirect_to :back
    end
  end

  def average
    ActiveRecord::Base.include_root_in_json = false
    render :json => Muni.find_by(route_name: params[:route_name]).to_json
  end
end
