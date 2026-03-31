class Muni < ActiveRecord::Base
  has_many :reports, dependent: :destroy
  validates :route_name, presence: true,
                         uniqueness: true
  validates_each :avg_smell_rating, :avg_clean_rating, :avg_driver_rating do |record, attr, value|
    record.errors.add(attr, 'must be integer from 1 to 5') unless (1..5).cover?(value)
  end

  class << self
    def sorted_munis
      munis = Muni.all
      munis.sort do |muni1, muni2|
        muni2.average_sum - muni1.average_sum
      end
    end
  end

  def update_averages
    %w[smell clean driver].each { |attr| send("avg_#{attr}_rating=", average_of("#{attr}_rating")) }
  end

  def average_of(attr)
    return 1 if reports.empty?

    (reports.inject(0.0) { |sum, r| sum + r.send(attr) } / reports.count).round
  end

  def average_sum
    avg_smell_rating + avg_clean_rating + avg_driver_rating
  end
end
