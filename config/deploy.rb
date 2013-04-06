set :application, "erikbenoist.com"
set :domain,      "ec2-54-225-83-176.compute-1.amazonaws.com"
set :repository,  "git@github.com:ebenoist/erikbenoist.com.git"
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

