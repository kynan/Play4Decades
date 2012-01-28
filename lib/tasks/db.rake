namespace :db do
  desc "Reset the database: drop, create, migrate, load fixtures."
  task :reset => [ :drop, :create, :migrate, 'fixtures:load' ]
end
