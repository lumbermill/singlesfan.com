class PagesController < ApplicationController
  def index
    @show_jumbotron = true
    @events = Event.where("opendate = ?",Date.today).order("opentime")
  end

  def about
    @title = "SINGLESって？"
  end

  def foodmenu
    @title = "メニュー"
  end

  def access
    @title = "アクセス"
  end
end
