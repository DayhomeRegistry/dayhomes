class ReviewsController < ApplicationController

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(params[:review])

    if @review.save
      flash[:notice] = "Review posted!"
    else
      render :action => :new
    end
  end

end