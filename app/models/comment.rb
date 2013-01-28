class Comment < ActiveRecord::Base
  attr_accessible :message, :post_id, :user_id
  belongs_to :user
  belongs_to :snippet
  validates_presence_of :message
end
