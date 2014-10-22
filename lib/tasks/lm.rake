namespace :lm do
  desc "Open browser for http://localhost:3000"
  task :open do
    `open http://localhost:3000`
  end

  desc "Deploy apps to sakura12 using pull method"
  task :pull do
    `ssh sakura12 "cd /opt/cb-singles.com && git pull"`
  end

  desc "Rsync to dev."
  task :dev do
    host = "dev.cb.lmlab.asia"
    path = "./"
    puts "Sending files to #{host}.."
    `rsync -avz --delete --exclude "tmp" --exclude "log" --exclude ".git" #{path} #{host}:/opt/#{host}/`
  end
  
  desc "Rsync to dev."
  task :www do
    host = "www.cb.lmlab.asia"
    path = "./"
    puts "Sending files to #{host}.."
    `rsync -avz --delete --exclude "tmp" --exclude "log" --exclude ".git" #{path} #{host}:/opt/#{host}/`
    puts "Compiling assets.."
    `ssh #{host} "cd /opt/#{host} && rake assets:precompile RAILS_ENV=production"`
    puts "Adjusting permissions.."
    `ssh #{host} "cd /opt/#{host} && chown -R nobody:nobody *"`
    `ssh #{host} "cd /opt/#{host} && chmod +r public/assets/*"`

    puts "Restarting web server.."
    `ssh #{host} "service httpd restart"`
  end

end
