class Muni < ActiveRecord::Base

    has_many :reports

    def change_ratings(muni)
        num = 0
        sum = 0
        muni.reports.each do |report| 
            sum += report.smell_rating
            num += 1
        end
        smell_rating = sum / num
        sum = 0
        num = 0
        muni.reports.each do |report| 
            sum += report.clean_rating
            num += 1
        end
        clean_rating = sum / num
        sum = 0
        num = 0
        muni.reports.each do |report| 
            sum += report.driver_rating
            num += 1
        end
        driver_rating = sum / num
        muni.uppdate_attributes(smell_rating: smell_rating, clean_rating: clean_rating, driver_rating: driver_rating)
    end
end
