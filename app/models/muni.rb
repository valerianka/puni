class Muni < ActiveRecord::Base

  has_many :reports
  validates :route_name, presence: true,
                         uniqueness: true

  class << self
    def sorted_munis
      munis = Muni.all 
      munis.sort do |muni1, muni2| 
        muni2.average_sum - muni1.average_sum
      end
    end

  end
  
  def update_averages
    %w(smell clean driver).each{ |attr| self.send("avg_#{attr}_rating=", average_of("#{attr}_rating"))}
  end

  def average_of(attr)
    reports.inject(0){ |accum, elem| accum + elem.send(attr) } / reports.count
  end

  def average_sum
    avg_smell_rating + avg_clean_rating + avg_driver_rating
  end

end
