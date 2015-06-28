class MunisController < ApplicationController

    def index

    end

    def show
        @muni = Muni.find_by(route_name: params[:route_name])
        @muni.reports.build(smell_rating: params[:smell_rating], clean_rating: params[:clean_rating], driver_rating: params[:driver_rating])
        @muni.update_avg_ratings
        @muni.save
    end

    def average
        @muni = Muni.where(route_name: params[:route_name]).first
        response = {smell: @muni.smell_score, clean: @muni.clean_score, driver: @muni.driver_score}
        render json: response.to_json


    end


end
