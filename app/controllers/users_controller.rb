class UsersController < ApplicationController
  # GET /users/:username
  def show
    @user = User.find_by!(name: params[:username])
    gon.jbuilder
  end
end
