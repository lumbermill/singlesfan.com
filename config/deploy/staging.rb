set :rails_env, 'production'
set :deploy_to, '/opt/dev.singlesfan.com'
server 'sakura15', user: fetch(:user), roles: %w{app db web}
