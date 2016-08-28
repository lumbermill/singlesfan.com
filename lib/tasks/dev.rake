
namespace :dev do
  desc 'Fetch dump from sakura16'
  task :fetch do
    # doesn't work on Vagrant environment, run directly on Mac.
    `ssh sakura16 mysqldump -uroot singlesfan_com_production > singlesfan.sql`
  end

  desc ''
  task :restore do
    `mysql -uroot singlesfan_com_development < singlesfan.sql`
  end
end
