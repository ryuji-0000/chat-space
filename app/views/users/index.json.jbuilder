json.users @users.all do |user|
  json.id user.id
  json.name user.name
end
