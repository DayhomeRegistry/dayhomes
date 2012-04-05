class DayHomesController < ApplicationController
  def show
    @day_home = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:id])

    if @day_home.nil?
      redirect_to '/404.html', :status => 301
    else
      @review = Review.new
      @reviews = @day_home.reviews.page(params[:page]).per(5)

      # simple email protection from spammers
      @contact = DayHomeContact.new({:day_home_email => Base64::encode64(@day_home.email)})
    end
  end

  def email_dayhome
    # decode email
    params[:day_home_contact][:day_home_email] = Base64::decode64(params[:day_home_contact][:day_home_email])

    # send email
    @contact = DayHomeContact.new(params[:day_home_contact])
    DayHomeContactMailer.contact_day_home(@contact).deliver
    redirect_to :back, :notice => "Dayhome has been contacted!"
  end

  def calendar
    @dayhome = DayHome.find(params[:id])
    @event = Event.new
  end

end