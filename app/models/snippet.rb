class Snippet < ActiveRecord::Base
  attr_accessible :absolute_url, :description, :heading, :image_url, :technology_id, :security
  validates_presence_of :absolute_url, :heading, :technology_id, :security
  validates_uniqueness_of :heading
  belongs_to :technology  
  has_many :comments
end
