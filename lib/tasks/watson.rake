require 'capistrano/cli'
require 'capistrano/cli/ui'

namespace :watson do

  branch = %x(git branch | grep '^*' | colrm 1 2).strip

  desc "Merge current branch's code into the 'master' branch, and push to the staging server"
  task :stage => [:check_branch, :check_tree, :check_rebase] do
    exit unless Capistrano::CLI.ui.agree("Are you sure you want to deploy to staging? (yes/no): ")
    # Make sure local master branch is up-to-date with remote master branch
    %x(git checkout master && git pull origin master)
    %x(git merge #{branch})
    %x(git push origin master)
    %x(git branch -f staging origin/staging)
    %x(git checkout staging)
    %x(git reset --hard origin/master)
    %x(git push -f origin staging)
    %x(cap staging deploy)
    %x(git checkout #{branch})
  end

  desc "Push green code from staging to production"
  task :launch => [:check_branch, :check_tree, :check_rebase] do
    exit unless Capistrano::CLI.ui.agree("Are you sure you want to deploy to production? (yes/no): ")
    %x(git branch -f production origin/production)
    %x(git checkout production)
    %x(git reset --hard origin/staging)
    %x(git push -f origin production)
    %x(cap production deploy)
    %x(git checkout #{branch})
    Rake::Task['watson:cleanup'].invoke unless ENV['CLEANUP'] == 'false'
  end

  desc "Clean up current branch by destroying local branch and remote tracking branch"
  task :cleanup => [:check_branch, :check_tree] do
    %x(git checkout master)
    %x(git push origin :heads/#{branch})
    %x(git branch -d #{branch})
  end

  desc "Prune local git repository of now deleted remote references"
  task :prune do
    %x(git remote prune origin)
  end

  %w(restart remigrate).each do |action|
    desc "#{action.capitalize} the specified server"
    task action.to_sym, :server do |task, args|
      if args.server.nil?
        puts "You must specify a server to #{action}."
        exit
      end
      %x(cap #{args.server} deploy:#{action})
    end
  end

  # Hidden tasks

  task :check_tree do
    %x(git fetch)
    if %x(git status | grep '^nothing to commit').blank?
      puts "Your working directory is not clean."
      puts "Commit and push, or stash your changes first."
      exit
    end
  end

  task :check_rebase do
    # Make sure local master branch is up-to-date with remote master branch
    %x(git checkout master && git pull origin master)
    %x(git checkout #{branch})
    current_master_position = %x(git branch -v | grep '^  master' | awk '{print $2}')
    contained_branches = %x(git branch --contains #{current_master_position})
    unless contained_branches.split("\n").collect(&:strip).include?("* #{branch}")
      puts "You must rebase from the 'master' branch first."
      exit
    end
  end

  task :check_branch do
    if %w(master staging production).include?(branch)
      puts "You cannot deploy from the '#{branch}' branch."
      exit
    end
  end

end