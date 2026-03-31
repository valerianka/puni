class Story < ActiveRecord::Base
  belongs_to :report
  validates :content, presence: true, length: { maximum: 1000 }
end
