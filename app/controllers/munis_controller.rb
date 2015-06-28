class MunisController < ApplicationController

    def index
        @report = Report.new
    end

    def update

    end

    def show
        @muni = Muni.find_by(route_name: params[:route_name])
        @muni.reports.build(smell_rating: params[:smell_rating], clean_rating: params[:clean_rating], driver_rating: params[:driver_rating])
        @muni.update_avg_ratings
        @muni.save
    end
end
