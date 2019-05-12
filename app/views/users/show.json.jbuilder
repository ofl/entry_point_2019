json.user do
  json.__typename 'User'
  json.id @user.id.to_s
  json.name @user.name
  json.avatarUrl @user.avatar_url
end
