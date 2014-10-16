class ForMaster::PagesController < ApplicationController
  before_action :check_auth
  
  def index
    @master = Master.find(session[:master_id])
  end

  def calc
  end
end
