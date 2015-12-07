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

    def define_update_avg(obj, name, val)
      define_method(name) {
        obj.send(name, val)
      } 
    end
  end
  
  def update_averages                       
    %w(smell clean driver).each{ |attr| Muni.define_update_avg(self, "update_avg_#{attr}_rating", average_of("#{attr}_rating".to_sym)) }
  end

  def average_of(attr)
    reports.inject(0){ |accum, elem| accum + elem.send(attr) } / reports.count
  end

  def average_sum
    avg_smell_rating + avg_clean_rating + avg_driver_rating
  end

end
