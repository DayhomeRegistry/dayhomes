namespace :init do
  task :env do
    unless File.exists?('.env')
      cp('.env.sample', '.env', :verbose => true)
    end
  end
end

unless Rake::Task.task_defined?("init")
  desc "Initializes the rails environment for development"
  task :init do ; end
end

# Add namespaced tasks to default :init task
Rake::Task["init"].enhance ["init:env"]
