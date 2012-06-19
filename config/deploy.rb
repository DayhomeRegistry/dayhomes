set :application, "dayhomes"
set :repository,  "git@github.com:dayhomeregistry/dayhomes.git"

        require './config/boot'
        require 'airbrake/capistrano'

# Custom maintenance page
#
# See http://ariejan.net/2011/09/19/capistrano-and-the-custom-maintenance-page
namespace :deploy do
  namespace :web do
    task :disable, :roles => :web, :except => { :no_release => true } do
      require 'erb'
      on_rollback { run "rm #{shared_path}/system/maintenance.html" }

      reason = ENV['REASON']
      deadline = ENV['UNTIL']

      template = File.read("./app/views/layouts/maintenance.html.erb")
      result = ERB.new(template).result(binding)

      put result, "#{shared_path}/system/maintenance.html", :mode => 0644
    end
  end
end