set :rails_env, 'production'
set :deploy_to, '/opt/singlesfan.com'
server 'sakura16', user: fetch(:user), roles: %w{app db web}
