class RemovePostIdFromSnippet < ActiveRecord::Migration
  def up
    remove_column :snippets, :post_id
  end

  def down
    add_column :snippets, :post_id, :integer
  end
end
