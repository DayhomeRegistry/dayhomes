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

    if params[:star].blank?
      @review.rating = 0
    else
      @review.rating = params[:star]
    end

    # populate review id's
    @review.user = current_user
    @review.day_home = @day_home

    if @review.save
      flash[:notice] = "Review posted!"
      redirect_to :back
    else
      error_msg = ''
      @review.errors.full_messages.each do |err|
        error_msg += "#{err}\n"
      end
      flash[:error] = error_msg
      redirect_to :back
    end
  end

end