json.array!(@pictures) do |picture|
  json.extract! picture, :picture_url,:id
end