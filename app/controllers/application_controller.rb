class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path, alert: 'Please login first'
  end

  def render(*args, &block)
    if current_user
      gon.currentUser = {
        id: current_user.id,
        name: current_user.name,
        avatar: current_user.avatar,
        __typename: 'currentUser'
      }
    end

    super
  end
end
