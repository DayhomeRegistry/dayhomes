class DayhomesController < ApplicationController
  layout 'beta'
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
  	@dayhomes = current_user.organization.day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 5)
  end
  def new
  end

  private
  def sort_column
    DayHome.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"    
  end  
end
