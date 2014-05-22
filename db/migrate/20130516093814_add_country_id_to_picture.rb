class AddCountryIdToPicture < ActiveRecord::Migration
  def change
    add_reference :pictures, :country, index: true
  end
end
