class Timeline < ActiveRecord::Base
  belongs_to :user

  def get_timeline(user_id)
    timeline_hash=[]
    timelines = Timeline.where("user_id=#{user_id}").limit(5)
    timelines.each do |timeline|
       logger.info(timeline.picture_id)
       picture = Picture.select("picture_url").where("id=#{timeline.picture_id}").first.picture_url
       logger.info(picture)
        temp_hash ={id:"#{timeline.id}",user_id:"#{timeline.user_id}",text:"#{timeline.text}",time:"#{timeline.time}",picture_url:"#{picture}",picture_id:"#{timeline.picture_id}"}
        logger.info(temp_hash)
        timeline_hash << temp_hash
    end 
    return timeline_hash
  end

  def get_timeline_by_userID_with_username (_user_id,_myID,_offset)
       timeline_hash=[]
      
       #user_statuses = Status.where("user_id=#{_user_id}")
        timelines = Timeline.where("user_id=#{_user_id}")
        temp_username = User.select("username").where("id=#{_user_id}").first.username
        pic = User.select("profileImage").where("id=#{_user_id}").first.profileImage
        

        #logger.info("temp_username #{temp_username}")
        timelines.each do |timeline|
           
          picture = Picture.select("picture_url,id").where("id=#{timeline.picture_id}").first
           totalLike = Like.where(picture_id: "#{timeline.picture_id}").count 
           totalComment = Comment.where(picture_id: "#{timeline.picture_id}").count 
           #Check Like Status
           likeStatus = Like.where(user_id:"#{_myID}",picture_id:"#{picture.id}").first
          if likeStatus==nil
            likeStatusCode = -1
           else
            likeStatusCode = likeStatus.id
           end

          temp_hash = {id:"#{timeline.id}",user_id:"#{timeline.user_id}",text:"#{timeline.text}",time:"#{timeline.time}",username:"#{temp_username}",profileImage:"#{pic}",picture_url:"#{picture.picture_url}",picture_id:"#{timeline.picture_id}",totalLike:"#{totalLike}",totalComment:"#{totalComment}",likeStatus:"#{likeStatusCode}"}
          logger.info("#{temp_hash}");
          timeline_hash << temp_hash
        end
       
        return timeline_hash
  end

  def get_timeline_with_json (_user_id,_offset) 
    timelist_list =[]
    timeline_show_list=[]
    logger.info("offset #{_offset}")
    #if _offset != "-1"
       logger.info("offset #{_offset} not -1")
        friend_ids = Friendship.where("user_id=#{_user_id}")
        logger.info(friend_ids.size())
    
         #GET Friends statuses
        friend_ids.each do |f_id|  
            get_timeline_by_userID_with_username(f_id.friend_id,_user_id,_offset).each do |_timeline|
              timelist_list << _timeline
            end
        end

        #GET My statuses
        get_timeline_by_userID_with_username(_user_id,_user_id,_offset).each do |_timeline|
          timelist_list << _timeline
        end
    
        timelist_list=timelist_list.sort_by{|e| e[:time]}.reverse
        5.times do |i|
          if  i+_offset.to_i < timelist_list.size()
            timeline_show_list << timelist_list[i+_offset.to_i]
          end
        end
    #end
    logger.info("all size #{timelist_list.size()}")
    return  timeline_show_list

  end

end
