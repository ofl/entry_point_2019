json.user do
  json.__typename 'User'
  json.id @user.id.to_s
  json.name @user.name
  json.avatarUrl @user.avatar_url
  json.followerCount @user.follower_count
  json.followingCount @user.following_count
end

json.followers @followers do |follower|
  json.__typename 'User'
  json.id follower.id.to_s
  json.name follower.name
  json.avatarUrl follower.avatar_url
  json.followerCount follower.follower_count
  json.followingCount follower.following_count
end
