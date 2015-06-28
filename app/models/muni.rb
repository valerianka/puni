class Muni < ActiveRecord::Base

    has_many :reports

    def smell_score
      ratings = []
      self.reports.each do |report|
        ratings << report.smell_rating
      end
      if ratings.length != 0
          smell_average = ratings.inject(:+)/ratings.length
      else
        return 2.4
      end
    end

    def clean_score
      ratings = []
      self.reports.each do |report|
        ratings << report.clean_rating
      end
      if ratings.length != 0
          clean_average = ratings.inject(:+)/ratings.length
      else
        return 3.2
      end
    end

    def driver_score
      ratings = []
      self.reports.each do |report|
        ratings << report.driver_rating
      end
      if ratings.length != 0
          driver_average = ratings.inject(:+)/ratings.length
      else
        return 2.9
      end
    end

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
