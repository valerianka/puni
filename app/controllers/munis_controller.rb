class MunisController < ApplicationController

    def index

    end

    def show
        # @muni = Muni.find_by(route_name: params[:route_name])
        # if @muni.reports
        #     @muni.reports.build(smell_rating: params[:smell_rating], clean_rating: params[:clean_rating], driver_rating: params[:driver_rating])
        #     @muni.update_avg_ratings
        #     @muni.save
        # end
        redirect_to munis_stinkchamp_path
    end

    def average
        p params
        @muni = Muni.where(route_name: params[:route_name]).first
        response = {smell: @muni.smell_score, clean: @muni.clean_score, driver: @muni.driver_score}
        render json: response.to_json


    end

    def stinkchamp
        render 'munis/show'
    end


end
