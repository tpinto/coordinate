#default_run_options[:pty] = true
#set :repository,  "git@github.com:tpinto/coordinate.git"
set :repository,  "git://github.com/tpinto/coordinate.git"
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
#set :scm_passphrase, "p00p" #This is your custom users password
set :user, "tpinto"

set :application, "barcamp"
set :domain, "barcamp.webreakstuff.com"
set :app_dir, "/home/tpinto/barcamp.webreakstuff.com"
set :use_sudo, false

set :username, "tpinto"
set :user, "tpinto"

set :deploy_to, "/home/tpinto/capistrano/barcamp"

role :app, "#{domain}"
role :web, "#{domain}"
role :db,  "#{domain}", :primary => true

desc "Restart the mongrel cluster"
namespace :deploy do
  task :restart, :roles => :app do
	  run("cd #{deploy_to}/current/ && mongrel_rails cluster::restart")
  end
end