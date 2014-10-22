class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_auth, except: [:index, :plain, :pasts, :show]

  # GET /events
  # GET /events.json
  def index
    @title = '営業スケジュール'
    d1 = Date.today
    d2 = d1 + 1.months
    @two_dates = [d1,d2]
    @two_events = []
    @two_events[0] = events_on_calendar(d1)
    @two_events[1] = events_on_calendar(d2)
  end

  def plain
    m1 = Date.today.beginning_of_month
    m2 = m1+ 1.months
    t1 = plain_of_month(m1)
    t2 = plain_of_month(m2)
    send_data t1+"\n\n"+t2, :type => 'text/plain', :disposition => "inline"
  end

  def pasts
    @title = '開催済み'
    @events = Event.pasts(params[:p])
  end


  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.master_name = Master.find(session[:master_id]).name
    @event.picture_id = 2;
    if params[:d]
      @event.opendate = params[:d]
    end
  end

  # GET /events/1/edit
  def edit
    @event.master_name = @event.master.name
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.master = master_by_name(params[:master_name])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'シフトを追加しました。' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        @event.master = master_by_name(params[:master_name])
        if @event.save
          format.html { redirect_to @event, notice: 'シフトを修正しました。' }
          format.json { render :show, status: :ok, location: @event }
        else
          format.html { render :edit }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:opendate, :opentime, :master_name, :title, :short_desc, :long_desc, :url, :picture_id, :submaster_id, :posted_by)
    end

    def master_by_name(n)
      Rails.logger.debug "New master: "+n
      m = Master.find_by(name: n)
      if !m
        # Add new master
        m = Master.create(name: n, email: n, password: PASSWORD_NULL);
      end      
      return m
    end

    def events_on_calendar(d)
      es = Event.monthly(d)
      events_array = []
      es.each do |e|
        if events_array.length < e.opendate.day + 1 then
          events_array[e.opendate.day] = []
        end
        events_array[e.opendate.day][e.opentime] = e
      end
      if events_array.length < d.end_of_month.day + 1 then
        events_array[d.end_of_month.day] = nil
      end
      return events_array
    end

    def plain_of_month(d)
      txt = d.month.to_s+"月度\n\n"
      events = Event.monthly(d)
      # todo: have to rewrite!! ..why?
      events_array = []
      events.each do |e|
        events_array[e.opendate.day] = e
      end
      for i in 1..d.end_of_month.day do
        dd = Date.new(d.year,d.month,i)
        txt += i.to_s + %w(日 月 火 水 木 金 土)[dd.wday] + " "
        if events_array[i] then
          e = events_array[i]
          case e.opentime
          when 0 then
            txt += "【昼】"
          when 2 then
            txt += "【昼夜】"
          end
          txt += e.master.name
          txt += "「"+e.title+"」"
          txt += e.short_desc
        end
        txt += "\n" 
      end
      return txt
    end
end
