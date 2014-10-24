# This migration comes from spree_auth (originally 20120203010234)
class AddResetPasswordSentAtToSpreeUsers < ActiveRecord::Migration
  def change
    User.reset_column_information
    unless User.column_names.include?("reset_password_sent_at")
      add_column :users, :reset_password_sent_at, :datetime
    end
  end
end
