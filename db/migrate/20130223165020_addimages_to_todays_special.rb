class AddimagesToTodaysSpecial < ActiveRecord::Migration
  def change
    add_column :todays_specials, :image, :text
  end
end
