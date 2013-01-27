class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.string :name
      t.string :icon_path

      t.timestamps
    end
  end
end
