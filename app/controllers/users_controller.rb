class UsersController < ApplicationController
  before_filter :authorized!, only: :destroy

  # Public: User POSTs a public key, we store against some generated magic
  # words and log the user in.
  def create
    @user = User.create user_params
    session[:user_id] = @user.id

    redirect_to messages_path
  end

  # Public: Form to 'search' for users.
  def index
  end

  # Public: POST to search for a user by magic words.
  def search
    redirect_to users_path, alert: "You need to specify some magic words" and return if params[:magic_words].blank?
    redirect_to users_path, alert: "Not enough magic words" and return unless params[:magic_words].split(" ").length == AppConfig.magic_words.number

    user = User.find_by(magic_words: params[:magic_words])
    if user and !user.expired?
      redirect_to new_message_path(magic_words: user.magic_words)
    else
      redirect_to users_path, alert: "Couldn't find anyone with those magic words. Maybe they have expired? Please check with your sender."
    end
  end

  # Public: Page that creates a keypair.
  def new
    if current_user
      render "existing_or_new"
    else
      @user = User.new
    end
  end

  # Public: Page for logging the user out.
  def destroy
    current_user.destroy
    session[:user_id] = nil
  end

  private
  def user_params
    params.require(:user).permit(:public_key)
  end
end
