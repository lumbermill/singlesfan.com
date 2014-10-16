class Picture < ActiveRecord::Base
  has_many :events
  belongs_to :master

  scope :active, lambda { where("active = true") }
end
