json.array!(@comments) do |comment|
  json.extract! comment,:id,:text, :time,:user_id,:username,:profileImage
end