namespace :deploy do
	desc <<-DESC
	  [internal] Copies stripe.rb from shared_path into release_path.
	DESC
	task :cp_stripe_initializer do
		run "cp #{shared_path}/config/initializers/stripe.rb #{release_path}/config/initializers/stripe.rb"
	end
end

after "deploy:finalize_update", 'deploy:cp_stripe_initializer'