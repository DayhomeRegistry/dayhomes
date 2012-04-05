class EventsController < ApplicationController
  def index
    @events = Event.scoped
    @events.where('day_home_id = ?', params[:day_home_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  def show
    @event = Event.where('id = ? AND day_home_id = ?', params[:id], params[:day_home_id]).first

    respond_to do |format|
      format.js { render :json => @event.to_json }
    end
  end

  def new
    @event = Event.new

    respond_to do |format|
      format.xml  { render :xml => @event }
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @day_home = DayHome.find(params[:day_home_id])
    @event = Event.new(params[:event])

    # date comes in as 04/04/2012 06:30 am, need to convert it to Ruby DateTime
    @event.starts_at = DateTime.parse(params[:event][:starts_at])
    @event.ends_at = DateTime.parse(params[:event][:ends_at])

    respond_to do |format|
      if @event.save
        @event.day_home = @day_home
        @event.save!
        format.js {}
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.js {}
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.where('id = ? AND day_home_id = ?', params[:id], params[:day_home_id]).first

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.js { }
      else
        format.js  { }
      end
    end
  end


  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
