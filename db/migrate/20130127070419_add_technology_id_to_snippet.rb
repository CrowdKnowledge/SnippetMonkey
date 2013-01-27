class AddTechnologyIdToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :technology_id, :integer
  end
end
