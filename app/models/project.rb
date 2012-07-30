class Project < ActiveRecord::Base
  attr_accessible :caption, :description, :name, :url
  has_many :images, :as => :imageable
end
