json.array!(@friendships) do |friendship|
  json.extract! friendship,:relationID,:friend_id,:username,:profileImage,:status
end