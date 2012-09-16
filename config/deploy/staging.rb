set :rails_env, "staging"
set :bundle_flags, "--deployment --binstubs --without development test darwin sunos mswin"

server '198.101.207.75', :app, :web, :db, :primary => true
