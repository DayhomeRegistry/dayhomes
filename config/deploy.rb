set :application, "dayhomes"
set :repository,  "git@github.com:DayhomeRegistry/dayhomes.git"

require './config/boot'
require 'airbrake/capistrano'

set :default_environment, {
  'PATH' => "/srv/dayhomes_staging/current/bin:/usr/bin/ruby:/usr/local/bin/rails:/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:/usr/local/rbenv/shims:/usr/local/rbenv/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
}


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