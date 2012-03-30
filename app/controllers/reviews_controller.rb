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

    unless params[:star].blank?
      @review.rating = params[:star]
    end

    # populate review id's
    @review.user = current_user
    @review.day_home = @day_home

    if @review.save
      redirect_to :back, :notice => "Review posted!"
    else
      error_msg = []
      @review.errors.full_messages.each do |err|
        error_msg << err
      end
      flash[:error] = error_msg.join("<br/>").html_safe
      redirect_to :back
    end
  end

end