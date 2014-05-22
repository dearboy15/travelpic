json.array!(@likes) do |like|
  json.extract! like,:id,:user_id,:username,:profileImage
end