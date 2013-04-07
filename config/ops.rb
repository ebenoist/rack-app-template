virtual_host_config = <<-CONFIG
  upstream #{Application.config["application_name"]} {
          server 127.0.0.1:#{Application.config["port"]};
      }

  server {
              listen   80;
              server_name  www.#{Application.config["domain"]};
              rewrite ^/(.*) http://#{Application.config["domain"]} permanent;
             }


  server {
              listen   80;
              server_name #{Application.config["domain"]};

              access_log /home/ubuntu/#{Application.config["application_name"]}/current/log/access.log;
              error_log /home/ubuntu/#{Application.config["application_name"]}/current/log/error.log;

              root   /home/ubunut/#{Application.config["application_name"]}/current/public/;
              index  index.html;

              location / {
                            proxy_set_header  X-Real-IP  $remote_addr;
                            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
                            proxy_set_header Host $http_host;
                            proxy_redirect off;

                            if (-f $request_filename/index.html) {
                                             rewrite (.*) $1/index.html break;
                            }

                            if (-f $request_filename.html) {
                                             rewrite (.*) $1.html break;
                            }

                            if (!-f $request_filename) {
                                             proxy_pass http://#{Application.config["application_name"]};
                                             break;
                            }
              }

  }
CONFIG

namespace :ops do
  task :create_virtual_host do
    put(virtual_host_config, "/tmp/#{Application.config["application_name"]}")
    run("#{sudo} mv /tmp/#{Application.config["application_name"]} /etc/nginx/sites-enabled/")
  end

  task :restart_nginx do
    run("#{sudo} service nginx restart")
  end
end

