class ReviewsController < ApplicationController

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @day_home = DayHome.find(params[:day_home_id])
    @review = Review.new(params[:review])

    unless params[:star].nil?
      @review.rating = params[:star]
    else
      @review.rating = 0
    end

    if @review.save
      current_user.reviews << @review
      @day_home.reviews << @review
      flash[:notice] = "Review posted!"
      redirect_to :back
    else
      render :action => :new
    end
  end

end