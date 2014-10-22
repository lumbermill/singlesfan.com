class ForMaster::PagesController < ApplicationController
  before_action :check_auth
  
  def index
    @title = "マスターメニュー"
    @master = Master.find(session[:master_id])
  end

  def calc
    @title = "日報計算機"
  end
end
