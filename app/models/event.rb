class Event < ActiveRecord::Base

  scope :calendar_event, lambda { |id, day_home_id|
    where('id = ? AND day_home_id = ?', id, day_home_id)
 }

  validates_presence_of :title, :starts_at, :ends_at
  validate :start_must_be_before_end_time

  belongs_to :day_home

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
        :id => self.id,
        :title => self.title,
        :description => self.description || "",
        :start => starts_at.rfc822,
        :end => ends_at.rfc822,
        :allDay => self.all_day,
        :recurring => false
        #:url => Rails.application.routes.url_helpers.event_path(id)
    }

  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

private
  def start_must_be_before_end_time
    errors.add(:starts_at, "date & time must be greater than or equal to the end date & time") if
        self.ends_at < self.starts_at
  end
end
