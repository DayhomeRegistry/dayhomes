set :application, "dayhomes"
set :repository,  "git@github.com:burmis/dayhomes.git"

set :stages, %w{vagrant staging production}
set :default_stage, "staging"
