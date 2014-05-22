json.array!(@countries) do |country|
  json.extract! country,:id, :country_name
end