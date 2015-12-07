class Report < ActiveRecord::Base
    belongs_to :muni
    has_one :story
    validates_each :smell_rating, :clean_rating, :driver_rating do |record, attr, value|
      record.errors.add(attr, 'must be integer from 1 to 5') if !(1..5).include?(value)
    end
end
