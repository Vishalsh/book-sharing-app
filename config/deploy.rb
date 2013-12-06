#require 'capistrano/ext/multistage'

set :application, "booksharingapp"
set :scm, :git
set :branch, "master"
set :repository, "https://github.com/Vishalsh/book-sharing-app"

default_run_options[:pty] = true

set :user, "user"
set :scm_passphrase, "p@ssw0rd"
set :use_sudo, false
set :sudo_password, "p@ssw0rd"
set :deploy_via, :copy

set :copy_remote_dir, "/home/user/repo"
#set :ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
set :ssh_options, { :forward_agent => true }


set :deploy_to, "/home/user/BookSharing"

set :stages, ["staging"]
set :default_stage, "staging"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "10.10.5.111"                          # Your HTTP server, Apache/etc
role :app, "10.10.5.111"                          # This may be the same as your `Web` server
role :db,  "10.10.5.111", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
  desc "Symlink shared config files"
  task :symlink_config_files do
    #run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  end

  desc "Open firewall port for server"
  task :open_firewall_port do
    run "sudo iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 3000 -j ACCEPT; sudo /etc/init.d/iptables save; sudo /etc/init.d/iptables restart; "
  end

  desc "Restart Passenger app"
  task :restart do
    run "sudo touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
    run " BUILD_ID=dontKillMe;    kill -9 $( /usr/sbin/lsof -i:3000 -t );    bundle exec rails s &"
  end
end

after "deploy", "deploy:symlink_config_files"
after "deploy:symlink_config_files", "deploy:open_firewall_port"
after "deploy:open_firewall_port", "deploy:restart"
