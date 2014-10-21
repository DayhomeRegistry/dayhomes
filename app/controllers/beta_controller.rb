class BetaController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :list]

  # Redirect default
  def show
    redirect_to beta_list_path()
  end
	# Landing page
	def list
    @disable_subnav=true
	end

  def dashboard
  end

	def new
		@params = params
	end

	


end
