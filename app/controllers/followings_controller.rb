class FollowingsController < ApplicationController
  # GET /users/:user_name/followings
  def index
    @user = User.find_by!(name: params[:user_name])
    @followings = @user.followings
    gon.jbuilder
  end
end
