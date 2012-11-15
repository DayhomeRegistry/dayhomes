namespace :deploy do
  desc "cp_stripe_initializer"
  task :cp_stripe_initializer do
    run "cp /srv/dayhomes_staging/shared/config/initializers/stripe.rb /srv/dayhomes_staging/current/config/initializers/stripe.rb"

  end
end

after 'deploy:update_code', 'deploy:cp_stripe_initializer'