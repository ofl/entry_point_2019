class ApplicationController < ActionController::Base
  before_action :require_login, :check_format

  private

  def not_authenticated
    redirect_to login_path, alert: 'Please login first'
  end

  def render(*args, &block)
    if current_user
      gon.currentUser = {
        id: current_user.id.to_s,
        name: current_user.name,
        email: current_user.email,
        avatarUrl: current_user.avatar_url,
        __typename: 'currentUser'
      }
    end

    super
  end

  def check_format
    return unless request.get?

    return if params[:format].nil?

    render nothing: true, status: 406 unless ['json', 'html'].include?(params[:format])
  end
end
