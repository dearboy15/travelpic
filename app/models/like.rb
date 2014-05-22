class Like < ActiveRecord::Base
  def getUserInfoWhoLikedThisPicture(picture_id)
    liketemp_hash = []
    likes = Like.where(picture_id: "#{picture_id}")
      likes.each do |like|
        user = User.where(id: "#{like.user_id}").first
        tem = {id: "#{like.id}",user_id: "#{user.id}" ,username: "#{user.username}", profileImage: "#{user.profileImage}"}
        liketemp_hash << tem
      end

      return liketemp_hash
    
  end
end
