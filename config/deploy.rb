require "./initialize"
require "application"
require "bundler/capistrano"
require "rvm/capistrano"

#Values are set in config/application.yml
set :application, Application.config["application_name"]
set :domain,      Application.config["domain"]
set :repository,  Application.config["repository"]
set :deploy_to,   "/home/ubuntu/#{application}"
set :use_sudo,    false
set :scm,         "git"
set :user,        Application.config["deploy_user"]
set :deploy_via, :remote_cache
set :normalize_asset_timestamps, false

role :app, domain
role :web, domain
role :db,  domain, :primary => true

#SET UP RVM
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")
set :rvm_install_ruby_params, '--1.9'      # for jruby/rbx default to 1.9 mode
set :rvm_install_pkgs, %w[libyaml openssl] # package list from https://rvm.io/packages
set :rvm_install_ruby_params, '--with-opt-dir=/usr/local/rvm/usr' # package support

before 'deploy:setup', 'rvm:install_rvm'   # install RVM
before 'deploy:setup', 'rvm:install_ruby'  # install Ruby and create gemset, or:
before 'deploy:setup', 'rvm:create_gemset' # only create gemset
after 'deploy:setup', 'deploy:upload_config' # upload config to shared
after 'deploy:create_symlink', 'deploy:link_config' # link the application.yml in shared

namespace :deploy do
  task :upload_config do
    application_config = File.read(Application.root + "/config/application.yml")
    run("mkdir -p #{shared_path}/config")
    put(application_config, "#{shared_path}/config/application.yml")
  end

  task :link_config do
    run("ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml")
  end

  task :start do
    run("cd #{current_path} && bundle exec rake start")
  end

  task :stop do
    run("cd #{current_path} && bundle exec rake stop")
  end

  task :restart do
    run("cd #{current_path} && bundle exec rake restart")
  end
end



