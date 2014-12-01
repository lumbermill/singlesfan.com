class MastersController < ApplicationController
  before_action :set_master, only: [:show, :edit, :update, :destroy]
  before_action :check_auth, except: [:reset, :reset_do, :show, :new, :new_do]
  
  PASSWORD_SRC = 'AaBbCcDdEeFfGgHhiJjKkLMmNnPpQrSsTtUuVvWwXxYyZz23456789'

  def reset    
  end

  def reset_do
    m = Master.find_by(email: params[:email]);
    if ! m 
      render :reset, notice: 'メールアドレスが見つかりません。'
    end
  end

  # GET /masters
  # GET /masters.json
  def index
    @masters = Master.all
  end

  # GET /masters/1
  # GET /masters/1.json
  def show
     b = (Date.today - 2.months).to_s # 1 month for future
     @count_in3months = @master.events.where("opendate > '#{b}'").count
     @title = "「"+@master.name+"」"
  end

  # GET /masters/new
  def new
    @master = Master.new
  end

  # GET /masters/1/edit
  def edit
  end

  def new_do
    @master = Master.find_by(name: master_params[:name]) || Master.new(master_params)
    @master.email = master_params[:email]
    p = PASSWORD_SRC.split(//).shuffle[0,6].join 
    @master.password = p
    @master.active = false

    respond_to do |format|
      if @master.save
        Notifications.signup(@master,p).deliver
        Rails.logger.debug "Mail:#{@master.email} Password:#{p}"
        Rails.logger.debug "You need to exec Member.find(#{@master.id}) on console."
        format.html { render :new_do, notice: '登録申請を受け付けました。' }
        format.json { render :show, status: :created, location: @master }
      else
        format.html { render :new }
        format.json { render json: @master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /masters/1
  # PATCH/PUT /masters/1.json
  def update
    respond_to do |format|
      if @master.update(master_params)
        format.html { redirect_to @master, notice: 'マスター情報を更新しました。' }
        format.json { render :show, status: :ok, location: @master }
      else
        format.html { render :edit }
        format.json { render json: @master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /masters/1
  # DELETE /masters/1.json
  def destroy
    @master.destroy
    respond_to do |format|
      format.html { redirect_to masters_url, notice: 'マスターを削除しました。' }
      format.json { head :no_content }
    end
  end

  def show_picture
    set_master
    if @master.picture
      send_data @master.picture, :type => 'image/jpeg', :disposition => "inline"
    else
      raise ActionController::RoutingError.new('Picture of '+@master.name+"' not found")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master
      @master = Master.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_params
      p = params.require(:master).permit(:name, :email, :picture, :desc, :broken_dishes, :job, :url, :id_facebook, :id_mixi, :id_twitter)
      require 'RMagick'
      if p[:picture] != nil then
        i = Magick::Image.from_blob(p[:picture].read)[0]
        if i.columns > 400
          p[:picture] = i.resize_to_fill(400).to_blob
        else
          p[:picture] = i.to_blob
        end
      end
      return p
    end
end
