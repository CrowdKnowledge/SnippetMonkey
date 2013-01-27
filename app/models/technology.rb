class Technology < ActiveRecord::Base
  attr_accessible :icon_path, :name
  has_many :snippets
end
