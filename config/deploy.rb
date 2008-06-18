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

after "deploy:update_code","deploy:copy_config"

desc "Restart the mongrel cluster"
namespace :deploy do
  task :restart, :roles => :app do
	  run("cd #{deploy_to}/current/ && mongrel_rails cluster::restart")
  end
end

desc "Copy database.yml"
namespace :deploy do
	task :copy_config, :roles => :app do
		run("rm #{deploy_to}/current/config/database.yml && cp #{deploy_to}/shared/config/database.yml #{release_path}/config/")
	end
end

desc "Copy index.htmll"
namespace :deploy do
	task :set_splash, :roles => :app do
		run("mv #{release_path}/public/prod_index.html #{release_path}/public/index.html")
	end
end