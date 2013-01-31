class AddCommentsCountToSnippet < ActiveRecord::Migration
  def change
   add_column :snippets, :comments_count, :integer, :default => 0
   Snippet.reset_column_information
    Snippet.find_each do |u|
      Snippet.reset_counters u.id, :comments
    end
  end
end
