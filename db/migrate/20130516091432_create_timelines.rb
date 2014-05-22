class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.string :text
      t.datetime :time

      t.timestamps
    end
  end
end
