class Project < ActiveRecord::Base
  attr_accessible :caption, :description, :name, :skills, :url
  
  has_many :images, :as => :imageable
  
  serialize :skills
  
end
