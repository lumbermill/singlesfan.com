class PagesController < ApplicationController
  def index
    @events = Event.where("opendate = ?",Date.today).order("opentime")
  end

  def about
  end

  def foodmenu
  end

  def access
  end
end
