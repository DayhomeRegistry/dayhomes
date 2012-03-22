class DayHomesController < ApplicationController
  def show
    @day_home = DayHome.find(params[:id])
  end
end