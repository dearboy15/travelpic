class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User", :foreign_key =>"friend_id"


   def getMyfriends(_user_id) 
      ids =[]
      friend_list=[]
      friendships_ids = Friendship.select("id,friend_id").where(user_id: _user_id)
      for friendships_id in friendships_ids do
         #ids<<friendships_id.friend_id
           logger.info("relationship #{friendships_id.id}");
           temp_username = User.select("username").where("id=#{friendships_id.friend_id}").first.username
           pic = User.select("profileImage").where("id=#{friendships_id.friend_id}").first.profileImage
           temp_hash ={relationID:"#{friendships_id.id}",friend_id:"#{friendships_id.friend_id}",username:"#{temp_username}",profileImage:"#{pic}",status:"1"} 
           friend_list << temp_hash

        end

        return friend_list    
   end

    def getMyfriendsMe(_user_id) 
      ids =[]
      friend_list=[]
      friendships_ids = Friendship.select("id,user_id").where(friend_id: _user_id)
      for friendships_id in friendships_ids do
         ids << friendships_id.user_id
      end
      logger.info(ids);
      for id in ids do
           temp_username = User.select("username").where("id=#{id}").first.username
           pic = User.select("profileImage").where("id=#{id}").first.profileImage
           #check the follower which user following or not 
           getStatus = Friendship.where(user_id:"#{_user_id}",friend_id:"#{id}").first
           if(getStatus==nil)
            statusCode =0
            relationshipID=-1
          else
            statusCode=1
            relationshipID=getStatus.id
          end

           temp_hash ={relationID:"#{relationshipID}",friend_id:"#{id}",username:"#{temp_username}",profileImage:"#{pic}",status:"#{statusCode}"}

           friend_list << temp_hash
        end

        return friend_list    
   end
end
