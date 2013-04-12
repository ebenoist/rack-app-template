require "./initialize"
require "application"

THIN_PID_FILE = "#{Application.root}/tmp/pids/rack.pid"

desc "Start server"
task :start do
  pid = spawn("cd #{Application.root} && thin --port #{Application.config["port"]} -d -P #{THIN_PID_FILE} -l #{Application.log_path} start")
  Process.wait(pid)
end

desc "Stop server"
task :stop do
  if File.exists?(THIN_PID_FILE)
    pid = spawn("cd #{Application.root} && thin -P #{THIN_PID_FILE} stop")
    Process.wait(pid)
  end
end

desc "Force restart"
task :force_restart do
  Rake::Task["stop"].execute
  system("rm #{THIN_PID_FILE}")
  Rake::Task["start"].execute
end

desc "Restart server"
task :restart do
  Rake::Task["stop"].execute
  Rake::Task["start"].execute
end


