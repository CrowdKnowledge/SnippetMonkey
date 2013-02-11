class AddShareCountToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :share_count, :integer, :null => false, :default => 0
  end
end
