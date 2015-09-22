set :rails_env, 'staging'
set :deploy_to, '/opt/dev.singlesfan.com'
server 'sakura15', user: fetch(:user), roles: %w{app db web}
