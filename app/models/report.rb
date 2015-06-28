class Report < ActiveRecord::Base
    belongs_to :muni
    validates :smell_rating, presence: true
    validates :clean_rating, presence: true
    validates :driver_rating, presence: true
end
