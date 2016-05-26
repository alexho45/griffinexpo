set :application, 'griffinexpo'
set :repo_url, 'git@github.com:alexho45/griffinexpo.git'
set :keep_releases, 5
set :branch, 'docker'

namespace :deploy do

  after :published, :restart_container do
    on roles(:web) do
      within release_path do
        execute 'cp', '/home/csuser/griffinexpo/docker-compose.yml', '.'
        execute 'cp', '/home/csuser/griffinexpo/Dockerfile', '.'
        execute 'docker-compose', 'build'
        execute 'docker-compose', 'restart'
        #sudo service docker restart
        #docker-compose up -d
      end
    end
  end

end
