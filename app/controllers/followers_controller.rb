class FollowersController < ApplicationController
  # GET /users/:user_name/followers
  def index
    @user = User.find_by!(name: params[:user_name])
    @followers = @user.followers
    gon.jbuilder
  end
end
