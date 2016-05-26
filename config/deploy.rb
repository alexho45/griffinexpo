set :application, 'griffinexpo'
set :repo_url, 'git@github.com:alexho45/griffinexpo.git'
set :keep_releases, 5
set :keep_assets, 5
set :branch, 'develop'
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads')
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :bundle_jobs, 7
