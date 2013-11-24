set :user, "ubuntu"
set :application, "watsonint"
set :repository, "git@github.com:tonywatson/watsonint.git"
set :deploy_to, "/home/ubuntu/watsonint"
set :deploy_via, :remote_cache
set :keep_releases, 2
set :scm, :git
set :use_sudo, false

role :web, "23.21.151.121"
role :app, "23.21.151.121"
role :db,  "23.21.151.121", :primary => true