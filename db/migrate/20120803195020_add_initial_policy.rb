class AddInitialPolicy < ActiveRecord::Migration
  def change
    PrivacyPolicy.create :version=>"1",:effective_date=>Time.now()
  end

end
