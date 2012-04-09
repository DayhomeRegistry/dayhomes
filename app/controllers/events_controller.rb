class EventsController < ApplicationController
  before_filter :require_user_to_be_day_home_owner, :except => [:show, :index]

  def index
    @events = Event.scoped
    @events.find_by_day_home_id(params[:day_home_id])

    respond_to do |format|
      format.js  { render :json => @events }
    end
  end

  def show
    @event = Event.calendar_event(params[:id], params[:day_home_id]).first

    respond_to do |format|
      format.js { render :json => @event.to_json }
    end
  end

  def create
    @day_home = DayHome.find(params[:day_home_id])
    @event = Event.new(params[:event])

    # date comes in as 04/04/2012 06:30 am, need to convert it to Ruby DateTime
    @event.starts_at = DateTime.parse(params[:event][:starts_at])
    @event.ends_at = DateTime.parse(params[:event][:ends_at])

    # set the event id
    @event.day_home = @day_home
    respond_to do |format|
      if @event.save
        format.js {}
      else
        format.js {}
      end
    end
  end

  def update
    @event = Event.calendar_event(params[:id], params[:day_home_id]).first

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.js { }
      else
        format.js  { }
      end
    end
  end


  def destroy
    @event = Event.calendar_event(params[:id], params[:day_home_id]).first
    @event.destroy

    respond_to do |format|
      format.js  { }
    end
  end

  private

  def require_user_to_be_day_home_owner
    unless current_user && current_user.day_home_owner?
      redirect_to root_path
    end
  end
end
