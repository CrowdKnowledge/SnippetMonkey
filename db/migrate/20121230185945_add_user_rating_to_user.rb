class AddUserRatingToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_rating, :float
  end
end
