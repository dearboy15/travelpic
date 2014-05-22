json.array!(@timelines) do |timeline|
  json.extract! timeline,:id, :text, :time, :picture_url,:picture_id,:profileImage,:user_id,:username,:totalLike,:totalComment,:likeStatus
end