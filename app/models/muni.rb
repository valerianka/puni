class Muni < ActiveRecord::Base

    has_many :reports
    validates :route_name, uniqueness: true
    before_save :default_avgs

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

    class << self
        def sorted_munis
            munis = Muni.all 
            munis.sort do |muni1, muni2| 
                muni1_avg_sum = muni1.avg_smelling_rating + muni1.avg_clean_rating + muni1.avg_driver_rating
                muni2_avg_sum = muni2.avg_smelling_rating + muni2.avg_clean_rating + muni2.avg_driver_rating
                muni2_avg_sum - muni1_avg_sum
            end
        end
    end

    def default_avgs
        avg_smelling_rating ||= 0
        avg_clean_rating ||= 0
        avg_driver_rating ||= 0
    end
end
