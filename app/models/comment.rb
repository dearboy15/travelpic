class Comment < ActiveRecord::Base
  def getCommentdata(picture_id)
    commenttemp_hash = []
    comments = Comment.where(picture_id: "#{picture_id}")
      comments.each do |comment|
        user = User.where(id: "#{comment.user_id}").first
        tem = {id: "#{comment.id}",text:"#{comment.text}",time:"#{comment.time}",user_id: "#{user.id}" ,username: "#{user.username}", profileImage: "#{user.profileImage}"}
        commenttemp_hash << tem
      end

      return commenttemp_hash
    
  end
end
