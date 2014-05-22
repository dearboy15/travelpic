class AddCatagoryIdToPicture < ActiveRecord::Migration
  def change
    add_reference :pictures, :category, index: true
  end
end
