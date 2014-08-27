namespace :deploy do
	desc <<-DESC
	  [internal] Copies facebook.yml from shared_path into release_path.
	DESC
	task :cp_facebook_settings do
		run "cp #{shared_path}/config/facebook.yml #{release_path}/config/facebook.yml"
	end
end

after "deploy:finalize_update", 'deploy:cp_facebook_settings'