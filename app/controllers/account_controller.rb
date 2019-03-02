class AccountController < ApplicationController
  skip_before_action :require_login, only: [:new]

  # GET /account/new
  def new
    redirect root_path if current_user

    @user = User.new
    gon.jbuilder
  end
end
