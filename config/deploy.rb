set :user, "ubuntu"
set :application, "watsonint"
set :repository, "git@github.com:tonywatson/watsonint.git"
set :deploy_to, "/home/ubuntu/rails"
set :deploy_via, :remote_cache
set :keep_releases, 2
set :scm, :git
set :use_sudo, false

role :web, "107.21.218.245"
role :app, "107.21.218.245"
role :db,  "107.21.218.245", :primary => true