json.user do
  json.__typename 'User'
  json.id @user.id.to_s
  json.name @user.name
  json.avatarUrl @user.avatar_url
  json.followerCount @user.follower_count
  json.followingCount @user.following_count
  json.followedByMe @user.followed_by?(current_user)
end
