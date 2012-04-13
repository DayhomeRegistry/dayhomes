class EventsController < ApplicationController
  before_filter :correct_safari_and_ie_accept_headers
  after_filter :set_xhr_flash
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

  def set_xhr_flash
    flash.discard if request.xhr?
  end

  def correct_safari_and_ie_accept_headers
    ajax_request_types = ['text/javascript', 'application/json', 'text/xml']
    request.accepts.sort! { |x, y| ajax_request_types.include?(y.to_s) ? 1 : -1 } if request.xhr?
  end
end
