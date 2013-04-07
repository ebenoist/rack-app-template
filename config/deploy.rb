require "bundler/capistrano"
require "rvm/capistrano"

set :application, "myrackapp.com"
set :domain,      "ec2-54-225-83-176.compute-1.amazonaws.com"
set :repository,  "git@github.com:ebenoist/rack-app-template.git"
set :deploy_to,   "/home/ubuntu/#{application}"
set :use_sudo,    false
set :scm,         "git"
set :user,        "ubuntu"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
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

set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")
set :rvm_install_ruby_params, '--1.9'      # for jruby/rbx default to 1.9 mode
set :rvm_install_pkgs, %w[libyaml openssl] # package list from https://rvm.io/packages
set :rvm_install_ruby_params, '--with-opt-dir=/usr/local/rvm/usr' # package support

before 'deploy:setup', 'rvm:install_rvm'   # install RVM
before 'deploy:setup', 'rvm:install_ruby'  # install Ruby and create gemset, or:
before 'deploy:setup', 'rvm:create_gemset' # only create gemset


