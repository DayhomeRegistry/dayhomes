class ReviewsController < ApplicationController

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    # since params[:day_home_id] will be present in the request
    # POST /day_homes/1/reviews
    # which translation to /day_homes/:day_home_id/reviews
    
    # @day_home = DayHome.find(params[:day_home_id])
    # @review = Review.new(params[:review])
    # @review.day_home = @day_home
    
    # In your view do form_for [@day_home, @review] do
    
    @review = Review.new(params[:review])

    if @review.save
      flash[:notice] = "Review posted!"
    else
      render :action => :new
    end
  end

end