class Event < ActiveRecord::Base
  belongs_to :master
  belongs_to :picture

  validates_presence_of :title
  validates_presence_of :opendate
  validates_presence_of :opentime
  validates_uniqueness_of :opentime, scope: [:opendate]
  validates_presence_of :master_id
 
  scope :recents, lambda { where("opendate >= ?",Date.today.to_s).order("opendate, opentime") }
  scope :recents_by_created, lambda { order("created_at") }
  scope :monthly, lambda { |d| 
    b = d.beginning_of_month
    e = d.end_of_month
    where("opendate between ? AND ?",b,e).order("opendate, opentime")
  }
  scope :pasts, lambda { |p|
    PAGE_SIZE = 24
    o = p * PAGE_SIZE
    where("opendate < ?",Date.today.to_s).order("opendate DESC,opentime").offset(o).limit(PAGE_SIZE)
  }

  # for new form
  attr_accessor :master_name

  def opendate_short
    d = opendate.day.to_s
    w = %w(日 月 火 水 木 金 土)[opendate.wday]
    d+w
  end

  def opentime_short
    %w(昼 夜 昼夜)[opentime]
  end

  def opentime_long
    opentime_short + " (" +%w(13:00-18:00 19:30-23:00 13:00-23:00)[opentime] + ")"
  end

  def masters_name
    return "" if master == nil || master.id == 1
    n = master.name
    if submaster_id then
      n += "&"+Master.find(submaster_id).name
    end
    return n
  end
end
