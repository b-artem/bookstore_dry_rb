namespace :snowboard do
  desc 'Show snowboard version'
  task :version do
    system('snowboard -v') || puts('Fail!')
  end
end
