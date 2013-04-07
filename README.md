Skeleton Rack Application
===============

Included is everything you might need to start a new rack based application.

#Getting Started
1. Create `config/application.yml` an example is provided in `config/application.yml.example`
2. `cap deploy:setup` will upload your config to the shared directory and prepare the application for deployment
3. `cap ops:create_virtual_host` will define a new nginx virtual host in /etc/nginx/sites-enabled/`your-application-name`
4. `cap ops:restart_nginx` will restart nginx
5. `cap deploy` will deploy and start the server
6. Enjoy
