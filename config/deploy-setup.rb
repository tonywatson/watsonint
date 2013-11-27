set :user, "ubuntu"
set :application, "watsonint"
set :repository, "git@github.com:tonywatson/watsonint.git"
set :deploy_to, "/home/ubuntu/watsonint"
set :deploy_via, :remote_cache
set :keep_releases, 2
set :scm, :git
set :use_sudo, false

role :web, "54.243.216.84"
role :app, "54.243.216.84"
role :db,  "54.243.216.84", :primary => true