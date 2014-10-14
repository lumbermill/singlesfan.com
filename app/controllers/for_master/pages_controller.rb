class ForMaster::PagesController < ApplicationController
  def index
    @master = Master.find(session[:master_id])
  end

  def calc
  end
end
