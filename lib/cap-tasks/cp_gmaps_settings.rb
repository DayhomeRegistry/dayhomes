namespace :deploy do
	desc <<-DESC
	  [internal] Copies gmaps.yml from shared_path into release_path.
	DESC
	task :cp_gmaps_settings do
		run "cp #{shared_path}/config/gmaps.yml #{release_path}/config/gmaps.yml"
	end
end

after "deploy:finalize_update", 'deploy:cp_gmaps_settings'