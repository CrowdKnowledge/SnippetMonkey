class AddSnippetIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :snippet_id, :integer
  end
end
