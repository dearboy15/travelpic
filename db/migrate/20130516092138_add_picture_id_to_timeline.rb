class AddPictureIdToTimeline < ActiveRecord::Migration
  def change
    add_reference :timelines, :picture, index: true
  end
end
