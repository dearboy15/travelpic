require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :timelines
  has_many :friendships
  before_save :encrypt_password
  
  def encrypt_password
    if self.password.present?
      self.password = Digest::SHA1.hexdigest(self.password)
    else
      self.password = self.password_was
    end
  end
 
  def registered?
    if user_data = User.where(username: "#{self.username}").first
         user_password  = user_data.password     
         input_password = Digest::SHA1.hexdigest(self.password) 
    
         if(user_password == input_password)
            self.id = user_data.id
            return true
          else
            return false
          end  
    else
        return false
    end
  end
end