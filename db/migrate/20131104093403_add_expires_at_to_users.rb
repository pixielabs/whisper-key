class AddExpiresAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :expires_at, :datetime

    User.find_each do |user|
      user.update_attribute :expires_at, user.created_at + AppConfig.user_expiry
    end
  end
end
