class DayHomesController < ApplicationController
  before_filter :require_user, :except => [:show, :email_dayhome, :calendar]
  before_filter :require_user_to_be_day_home_owner, :except => [:show, :email_dayhome, :calendar]
    
  def index
    @day_homes = current_user.day_homes
  end
  
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

    # check if a user is logged in
    if current_user
      # check if the user has a dayhome that's related with this id
      @day_home_admin = false
      current_user.day_homes.each do |day_home|
        if day_home.id == @dayhome.id
          # the user is related to the dayhome, admin found!
          @day_home_admin = true
          break
        else
          @day_home_admin = false
        end
      end
    else
      # no logged in user
      @day_home_admin = false
    end
  end


  def edit
    @day_home = current_user.day_homes.find(params[:id])
  end
  
  def update
    @day_home = current_user.day_homes.find(params[:id])
    
    if @day_home.update_attributes(params[:day_home])
      redirect_to day_homes_path
    else
      render :action => :edit
    end
  end

end