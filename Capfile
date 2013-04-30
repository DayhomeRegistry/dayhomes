load 'deploy'
set :stages, %w{new-prod staging production}
set :default_stage, "staging"


require 'capistrano/fanfare'

fanfare_recipe 'defaults'
fanfare_recipe 'multistage'
fanfare_recipe 'git_style'
fanfare_recipe 'bundler'
#fanfare_recipe 'assets' #don't think we're using this one
fanfare_recipe 'db_seed'

fanfare_recipe 'foreman'
fanfare_recipe 'database_yaml'

fanfare_recipe 'info'
fanfare_recipe 'colors'
#fanfare_recipe 'ssh' #never use this
#fanfare_recipe 'console' #never use this
# fanfare_recipe 'campfire'
# fanfare_recipe 'airbrake'

set :bundle_shebang,  "ruby"
set :branch, "new-prod"

Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb','lib/cap-tasks/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy'
