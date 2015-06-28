class MunisController < ApplicationController

    def index
        
    end

    def update
        @muni = Muni.find_by(route_name: params[:routename])
        @muni.reports.build(smell_rating: params[:smell], clean_rating: params[:cleanliness], driver_rating: params[:driver])
        change_ratings(@muni)
        @muni.save
        render 'munis/show'
    end

    def show

    end
end
