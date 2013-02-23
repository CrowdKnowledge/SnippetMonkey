class CreateTodaysSpecials < ActiveRecord::Migration
  def change
    create_table :todays_specials do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :type

      t.timestamps
    end
  end
end
