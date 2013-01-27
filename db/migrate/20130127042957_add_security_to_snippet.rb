class AddSecurityToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :security, :string
  end
end
