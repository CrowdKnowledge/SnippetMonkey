class AddCodeToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :code, :string
  end
end
