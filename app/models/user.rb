class User < ActiveRecord::Base
  acts_as_authentic
  
  attr_accessible :email_address, :password, :password_confirmation
end
