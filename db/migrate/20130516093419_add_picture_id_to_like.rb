class AddPictureIdToLike < ActiveRecord::Migration
  def change
    add_reference :likes, :picture, index: true
  end
end
