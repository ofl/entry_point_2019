class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    if logged_in?
      redirect_to(:root)
      return
    end

    gon.user = User.new
  end

  def create
    if login(params[:email], params[:password], params[:remember_me])
      redirect_back_or_to(:root, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      gon.user = User.new

      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:root, notice: 'Logged out!')
  end
end
