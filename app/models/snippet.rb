class Snippet < ActiveRecord::Base
  attr_accessible :absolute_url, :description, :heading, :image_url, :technology_id, :security, :user_id, :code
  validates_presence_of :heading, :technology_id, :security, :user_id
  validates_uniqueness_of :heading
  belongs_to :technology  
  has_many :comments
  belongs_to :user
end
