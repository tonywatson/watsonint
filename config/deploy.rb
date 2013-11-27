require 'bundler/capistrano'
require "rvm/capistrano"

set :user, "ubuntu"
set :application, "watsonint"
set :branch, "origin/master"
set :repository, "git@github.com:tonywatson/watsonint.git"
set :deploy_to, "/home/ubuntu/watsonint"
set :deploy_via, :remote_cache
set :keep_releases, 2
set :scm, :git
set :use_sudo, false
set :normalize_asset_timestamps, false
set :rvm_type, :user

task :staging do
  role :app, "174.129.14.212"
  set  :location, "174.129.14.212"
  role :web, location                   # Your HTTP server, Apache/etc
  role :db,  location, :primary => true # This is where Rails migrations will run
  set :rails_env, "staging"
end

task :production do
  role :app, "174.129.14.212"
  set  :location, "174.129.14.212"
  role :web, location                          # Your HTTP server, Apache/etc
  role :db,  location, :primary => true # This is where Rails migrations will run
  set :rails_env, "production"
end

namespace :deploy do
  desc "Deploy your application"
  task :default do
    update_code
    start
  end
  
  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
    finalize_update
  end
  
  task :finalize_update, :except => { :no_release => true } do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)

    # mkdir -p is making sure that the directories are there for some SCM's that don't
    # save empty folders
    run <<-CMD
      rm -rf #{latest_release}/log #{latest_release}/public/system #{latest_release}/tmp/pids &&
      mkdir -p #{latest_release}/public &&
      mkdir -p #{latest_release}/tmp &&
      ln -s #{shared_path}/log #{latest_release}/log &&
      ln -s #{shared_path}/system #{latest_release}/public/system &&
      ln -s #{shared_path}/pids #{latest_release}/tmp/pids &&
      ln -sf #{shared_path}/config/database.yml #{latest_release}/config/database.yml
    CMD
  end
  
  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{current_path}/tmp/pids/unicorn-#{application}.pid`"
  end
  
  desc "Start the app's Unicorn processes"
  task :start do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec unicorn_rails -c config/unicorn.rb -D"
  end
  
  desc "Stop the app's Unicorn processes"
  task :stop do
    run "kill `cat #{current_path}/tmp/pids/unicorn-#{application}.pid`"
  end
  
  desc "Remigrate the app's database"
  task :remigrate, :only => {:primary => true} do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake db:remigrate"
  end
  
  desc "Create symlinks for config files"
  task :symlink_configs do
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  
  desc "Setup your git-based deployment app"
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, shared_path]
    dirs += shared_children.map { |d| File.join(shared_path, d) }
    run "git clone #{repository} #{current_path}"
  end
  
end

after "deploy", "deploy:cleanup"
after "deploy:remigrate", "deploy:restart"