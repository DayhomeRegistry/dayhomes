class DayHomesController < ApplicationController
  def show
    @day_home = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:id])
    unless @day_home
      redirect_to '/404.html', :status => 301
    end

    @review = Review.new
    @reviews = @day_home.reviews.page(params[:page]).per(5)
  end
  
end