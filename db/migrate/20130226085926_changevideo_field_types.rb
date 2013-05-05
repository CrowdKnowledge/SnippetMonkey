class ChangevideoFieldTypes < ActiveRecord::Migration
 def change
  change_table :todays_specials do |t|  
    t.change :description, :text
    t.change :url, :text
    t.change :image, :text
    t.change :title, :text
  end
 end 
end
