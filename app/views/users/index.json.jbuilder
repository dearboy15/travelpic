json.array!(@users) do |user|
  json.extract! user, :username, :id, :profileImage,:status,:friendship_id
 
end