class AddConfirmStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :confirmation_status, :boolean
  end
end
