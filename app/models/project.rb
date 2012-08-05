class Project < ActiveRecord::Base.extend(ActiveSupport::Memoizable)
  attr_accessible :caption, :description, :name, :skills, :url
  
  has_many :images, :as => :imageable
  
  serialize :skills

  def project_name
    name
  end
  memoize :project_name
  
end
