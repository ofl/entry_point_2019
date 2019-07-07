class ApplicationController < ActionController::Base
  before_action :require_login, :check_format

  def render(*args, &block)
    if current_user
      gon.currentUser = {
        id: current_user.id.to_s,
        name: current_user.name,
        email: current_user.email,
        avatarUrl: current_user.avatar_url,
        followerCount: current_user.follower_count,
        followingCount: current_user.following_count,
        __typename: 'currentUser'
      }
    end

    super
  end

  private

  def not_authenticated
    redirect_to login_path, alert: 'Please login first'
  end

  def check_format
    return unless request.get?

    return if params[:format].nil?

    render nothing: true, status: 406 unless ['json', 'html', 'html'].include?(params[:format])
  end
end
