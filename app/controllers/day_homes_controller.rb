class DayHomesController < ApplicationController
  def show
    @day_home = DayHome.find(params[:id])
    @review = Review.new
  end
  
end