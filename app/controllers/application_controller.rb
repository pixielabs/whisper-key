class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private
  # Public: Return the current user if it exists. If the user is expired, unset
  # their session.
  def current_user
    @current_user ||= User.find_by_id session[:user_id]
    @current_user = session[:user_id] = nil if @current_user and @current_user.expired?
    return @current_user
  end

  # Public: Filter for pages that require you to be set up for receiving
  # whispers.
  def authorized!
    redirect_to root_url, alert: "You need to be set up for receiving whispers first" and return unless current_user
  end
end
