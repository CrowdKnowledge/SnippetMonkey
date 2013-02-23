class AddcolumschageToTodaysSpecial < ActiveRecord::Migration
  def change
    add_column :todays_specials, :special_type, :string
    remove_column :todays_specials, :type
  end
end
