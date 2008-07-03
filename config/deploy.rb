set :repository,  "git://github.com/tpinto/coordinate.git"
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :user, "tpinto"
set :username, "#{user}"

set :application, "barcamp"
set :domain, "#{application}.webreakstuff.com"
set :app_dir, "/home/#{username}/#{domain}"
set :use_sudo, false

set :deploy_to, "/home/#{username}/capistrano/#{application}"

role :app, "#{domain}"
role :web, "#{domain}"
role :db,  "#{domain}", :primary => true

after "deploy:update_code", "deploy:copy_config"
#before "deploy:restart", "deploy:set_splash"

desc "Restart the mongrel cluster"
namespace :deploy do
  task :restart, :roles => :app do
	  run("cd #{deploy_to}/current/ && mongrel_rails cluster::restart")
  end
end

desc "Copy database.yml"
namespace :deploy do
	task :copy_config, :roles => :app do
		run("cp #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml")
		run("cp #{deploy_to}/shared/config/production.rb #{release_path}/config/environments/production.rb")
	end
end

desc "Copy index.htmll"
namespace :deploy do
	task :set_splash, :roles => :app do
		run("mv #{deploy_to}/current/public/prod_index.html #{deploy_to}/current/public/index.html")
	end
end