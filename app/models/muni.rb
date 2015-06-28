class Muni < ActiveRecord::Base

    has_many :reports

    def update_avg_ratings
        num = 0
        sum = 0
        reports.each do |report| 
            sum += report.smell_rating
            num += 1
        end
        avg_smell_rating = sum / num
        sum = 0
        num = 0
        reports.each do |report| 
            sum += report.clean_rating
            num += 1
        end
        avg_clean_rating = sum / num
        sum = 0
        num = 0
        reports.each do |report| 
            sum += report.driver_rating
            num += 1
        end
        avg_driver_rating = sum / num
        update_attributes(avg_smelling_rating: avg_smell_rating, avg_clean_rating: avg_clean_rating, avg_driver_rating: avg_driver_rating)
    end
end
