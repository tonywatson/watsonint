class Image < ActiveRecord::Base

  attr_accessible :photo, :imageable_id, :imageable_type
  
  attr_accessor :image_file_name
  
  belongs_to :imageable, :polymorphic => true
  belongs_to :project

  has_attached_file  :photo, :styles => { :large => "1000>x650", :list => "300x200#", :tiny => "100x100#" }, 
                     :s3_credentials => "#{Rails.root}/config/s3.yml", :bucket => "#{Rails.env}_watsonint", :storage => :s3, 
                     :path => ":attachment/:id/:style.:extension"

  validates_attachment_size :photo, :less_than => 3.megabyte, :if => Proc.new {|a| a.photo.file?}

  validates_attachment_content_type :photo,
                                    :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/pjpeg','image/x-png'],
                                    :if => Proc.new {|a| a.photo.file?}
  
end
