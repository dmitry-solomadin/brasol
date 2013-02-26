require "i18n"
require "bundler/capistrano"
require "delayed/recipes"

set :rails_env, "production" #added for delayed job
set :application, "brasol"
set :repository, "git@github.com:znvPredatoR/brasol"
set :scm, "git"
set :user, "root"
set :scm_passphrase, "thequaker1"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "78.47.164.71" # Your HTTP server, Apache/etc
role :app, "78.47.164.71"
role :db, "78.47.164.71", :primary => true

set :deploy_to, "/data/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

default_run_options[:pty] = true
set :ssh_options, {:forward_agent => true}

namespace :starter do
  desc "Own deploy folder"
  task :prepare, :roles => :app do
    run "cd #{current_path} && cd .. && chown -R spree:spree ."
    run "cd #{current_path}/config && chmod +x brasol-starter"
  end

  desc "Start the application services"
  task :start, :roles => :app do
    run "cd #{current_path}/config && bash script brasol-starter start"
  end

  desc "Stop the application services"
  task :stop, :roles => :app do
    run "cd #{current_path}/config && bash script brasol-starter stop"
  end

  desc "Restart the application services"
  task :restart, :roles => :app do
    run "cd #{current_path}/config && ./brasol-starter restart"
  end
end

namespace :deploy do
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/cached-copy/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/s3.yml #{release_path}/config/s3.yml"
    run "ln -nfs #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
    run "ln -nfs #{shared_path}/cached-copy/config/Procfile #{release_path}/Procfile"
  end

  desc "Compile assets"
  task :precompile_assets, :roles => :app do
    run "cd #{release_path} && bundle exec rake assets:precompile --trace"
  end

  desc "Migrate db"
  task :migrate_db, :roles => :app do
    run "cd #{current_path} && bundle exec rake db:migrate --trace"
  end

  desc "Backup db"
  task :backup_db, :roles => :app do
    dump_date = I18n.l DateTime.now, format: "%d-%m-%Y_%H-%M"
    run "cd #{shared_path}/dbdump && mysqldump -uroot brasol > brasol_#{dump_date}.sql"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
after 'deploy:symlink_shared', 'deploy:precompile_assets'
after 'deploy:symlink_shared', 'deploy:migrate_db'
after 'deploy:update', 'deploy:backup_db'
after 'deploy:update', 'starter:prepare'
after 'deploy:update', 'starter:restart'

after "deploy:stop", "delayed_job:stop"
after "deploy:start", "delayed_job:restart"
after "deploy:restart", "delayed_job:restart"

require './config/boot'

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