class TodaysSpecial < ActiveRecord::Base
  attr_accessible :description, :title, :special_type, :url, :image
end
