class DayHomePhoto < ActiveRecord::Base
  mount_uploader :photo, DayHomePhotoUploader
  
  belongs_to :day_home
  validates_presence_of :photo
  
  #attr_accessible :caption, :default_photo, :photo

  # Override to silently ignore trying to remove missing
  # previous photo when destroying a User.
  def remove_photo!
    begin
      super
    rescue Fog::Storage::Rackspace::NotFound
    end
  end

  # Override to silently ignore trying to remove missing
  # previous photo when saving a new one.
  def remove_previously_stored_photo
    begin
      super
    rescue Fog::Storage::Rackspace::NotFound
      @previous_model_for_photo = nil
    end
  end
  
end