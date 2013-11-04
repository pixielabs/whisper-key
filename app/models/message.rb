class Message < ActiveRecord::Base
  validates :encrypted_data, presence: true
  validates :encrypted_key, presence: true
  validates :user_id, presence: true

  belongs_to :user

  validate :user_has_not_expired

  private
  def user_has_not_expired
    errors.add(:user, "has expired") if user.expired?
  end
end
