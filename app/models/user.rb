class User < ActiveRecord::Base
  validates :magic_words, presence: true, uniqueness: true
  validates :public_key, presence: true
  validates :expires_at, presence: true

  has_many :messages
  
  before_validation :assign_magic_words, on: :create
  before_validation :set_expires_at, on: :create

  def expired?
    expires_at < Time.now
  end

  # Override destroy & delete. We must retain users so that we do not re-assign
  # magic words. TODO: Refactor this way of not re-using magic words.
  def destroy
    update_attribute :expires_at, Time.now
    messages.delete_all
  end

  def delete
    destroy
  end

  private
  def assign_magic_words
    self.magic_words = MagicWords.new.to_s
  end

  def set_expires_at
    self.expires_at = Time.now + AppConfig.user_expiry
  end
end
