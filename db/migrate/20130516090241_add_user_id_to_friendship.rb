class AddUserIdToFriendship < ActiveRecord::Migration
  def change
    add_reference :friendships, :user, index: true
  end
end
