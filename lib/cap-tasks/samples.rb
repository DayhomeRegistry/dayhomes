# Create a new task to reset and seed the database
namespace :db do
	namespace :reset do
		desc "Reset the database"
		task :default do
	          rails_env = fetch(:rails_env, nil) || fetch(:rack_env, nil) || "production"

	          run %{cd #{current_path} && #{rake} RAILS_ENV=#{rails_env} db:reset}
		end

		desc "Reset the database, then load sample data"
		task :samples do
          rails_env = fetch(:rails_env, nil) || fetch(:rack_env, nil) || "production"

          run %{cd #{current_path} && #{rake} RAILS_ENV=#{rails_env} db:reset:samples}
		end
	end 

end