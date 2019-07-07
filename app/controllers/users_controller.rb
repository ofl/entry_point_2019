class UsersController < ApplicationController
  # GET /users/:name
  def show
    @user = User.find_by!(name: params[:name])
    gon.jbuilder
  end
end
