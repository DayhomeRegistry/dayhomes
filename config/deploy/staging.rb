set :rails_env, "staging"
set :bundle_flags, "--deployment --binstubs --without development test darwin sunos mswin"

server '166.78.149.139', :app, :web, :db, :primary => true
