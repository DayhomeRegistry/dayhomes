class DayHomesController < ApplicationController
  def show
    @day_home = DayHome.find(params[:id])
    @review = Review.new
    @reviews = @day_home.reviews.page(params[:page]).per(5)
  end
  
end