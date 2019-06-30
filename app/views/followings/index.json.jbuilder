json.user do
  json.__typename 'User'
  json.id @user.id.to_s
  json.name @user.name
  json.avatarUrl @user.avatar_url
  json.followerCount @user.follower_count
  json.followingCount @user.following_count
end

json.followings @followings do |following|
  json.__typename 'User'
  json.id following.id.to_s
  json.name following.name
  json.avatarUrl following.avatar_url
  json.followerCount following.follower_count
  json.followingCount following.following_count
end
