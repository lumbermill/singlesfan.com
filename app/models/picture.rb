class Picture < ActiveRecord::Base
  has_many :events

  scope :active, lambda { where("active = 't'") }
end
