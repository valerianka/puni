class MunisController < ApplicationController

    def index

    end

    def update
        @muni = Muni.find_by(route_name: params[:routename])
        @muni.reports.build(smell_rating: params[:smell], clean_rating: params[:cleanliness], driver_rating: params[:driver])
        change_ratings(@muni)
        @muni.save
    end

    def show

    end

    def average
        @muni = Muni.where(route_name: params[:route_name]).first
        response = {smell: @muni.smell_score, clean: @muni.clean_score, driver: @muni.driver_score}
        render json: response.to_json


    end


end
