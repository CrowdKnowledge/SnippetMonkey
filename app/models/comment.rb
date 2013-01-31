class Comment < ActiveRecord::Base
  attr_accessible :message, :snippet_id, :user_id
  belongs_to :user
  belongs_to :snippet, :counter_cache => true
  validates_presence_of :message
end
