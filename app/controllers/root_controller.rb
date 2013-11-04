class RootController < ApplicationController
  def index; end

  def about
    render layout: 'application'
  end
end
