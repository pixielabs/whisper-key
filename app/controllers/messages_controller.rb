class MessagesController < ApplicationController
  before_filter :authorized!, only: :show

  # Public: Create a message - user passes the encrypted message and user_id.
  # We can't verify that the message really is for that user ID, but it won't
  # be able to be decrypted or fiddled with if they fudge it.
  def create
    @user = User.find message_params[:user_id]
    @user.messages.create message_params
    redirect_to root_url, notice: "Encrypted message sent!"
  end

  # Public: Show a single message (the encrypted one anyway)
  def show
    @message = current_user.messages.find params[:id]
  end

  # Public: Form for creating a new message, should have a user ID by this
  # point, because we'll need to supply the user with the public key.
  def new
    @user = User.find params[:user_id]
    @message = @user.messages.build
  end

  # Public: Show list of messages for logged in user.
  def index
    if current_user
      @messages = current_user.messages.order("created_at DESC").page params[:page]
    end
    if request.xhr?
      if current_user
        render partial: "messages", layout: false
      else
        render text: "You are no longer receiving messages for these magic words"
      end
    else
      authorized!
      render
    end
  end

  private
  def message_params
    params.require(:message).permit(:user_id, :encrypted_data, :encrypted_key)
  end
end
