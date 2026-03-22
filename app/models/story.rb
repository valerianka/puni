class Story < ActiveRecord::Base
    belongs_to :report
    validates :content, presence: true
end
