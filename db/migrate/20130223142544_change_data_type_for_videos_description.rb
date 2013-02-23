class ChangeDataTypeForVideosDescription < ActiveRecord::Migration
def change
change_table :videos do |t|  
  t.change :description, :text
end
end
end
