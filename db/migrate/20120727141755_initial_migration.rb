class InitialMigration < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email_address, :crypted_password, :password_salt, :persistence_token, :perishable_token, :null => false
      t.integer :login_count, :failed_login_count, :null => false, :default => 0
      t.string :current_login_ip, :last_login_ip
      t.datetime :current_login_at, :last_login_at, :activated_at, :opted_out_at
      t.timestamps
    end
    
    create_table :projects do |t|
      t.string :name, :caption, :description, :url
      t.timestamps
    end
    
    create_table :photos do |t|
      t.has_attached_file :image
      t.timestamps
    end
  end
  
  def self.down
    File.read(__FILE__).scan(/create_table :(\w+)/).each { |table| drop_table table[0].to_sym }
  end
end
