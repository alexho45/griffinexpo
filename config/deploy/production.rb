server 'exporeg.griffins.com', user: 'csuser', roles: %w{app db web}
set :deploy_to, '/home/csuser/griffinexpo'
set :rails_env, 'production'
