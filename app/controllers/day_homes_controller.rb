class DayHomesController < ApplicationController
  def show
    @day_home = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:id])

    if @day_home.nil?
      redirect_to '/404.html', :status => 301
    else
      @review = Review.new
      @reviews = @day_home.reviews.page(params[:page]).per(5)
      @contact = DayHomeContact.new({:day_home_email => @day_home.email})
    end
  end

  def email_dayhome
    @contact  = DayHomeContact.new(params[:day_home_contact])
    redirect_to :back
  end


end