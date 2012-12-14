class DayHomesController < ApplicationController

  before_filter :require_user, :except => [:show, :contact, :calendar, :followup]
  before_filter :require_user_to_be_day_home_owner_or_admin, :except => [:show, :contact, :calendar, :followup]
  helper_method :sort_column, :sort_direction
    
  def index
    if (!params[:query].nil?)
      clause = params[:query]      
      result = clause.scan(/(\bfeatured:\b[^\s]*)/)            
      feature = result.length==0 ? "" : result[0][0]
      result = clause.scan(/(\bapproved:\b[^\s]*)/)
      approve = result.length==0 ? "" : result[0][0]  
      clause = clause.gsub(feature,"")
      clause = clause.gsub(approve,"")            
      
      if (current_user.agency_admin?)
        if (!clause.empty?)
          @day_homes = current_user.agencies.first.day_homes.where("name like ?", "%#{clause.strip}%")
        else
          @day_homes = current_user.agencies.first.day_homes
        end
      else 
        if (!clause.empty?)
          @day_homes = current_user.day_homes.where("name like ?", "%#{clause.strip}%")
        else
          @day_homes = current_user.day_homes
        end
      end
      #return render :text=> clause.strip+"|"+feature+"|"+approve
      
      if(!feature.empty?)            
        @day_homes = @day_homes.where(:featured=> feature=="featured:yes")
      end
      if(!approve.empty?)
        @day_homes = @day_homes.where(:approved=> approve=="approved:yes")
                
      end
      @day_homes = @day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
      @query = params[:query]
    else 
      
      if (current_user.agency_admin?)      
        @day_homes = current_user.agencies.first.day_homes
      else
        @day_homes = current_user.day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)      
      end
    end
  end
  
  def show
    @day_home = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:id])

    if @day_home.nil?
      redirect_to '/404.html', :status => 301
    else
      @review = Review.new
      @reviews = @day_home.reviews.page(params[:page]).per(5)

      # simple email protection from spammers
      @day_home_contact = DayHomeContact.new({:day_home_email => Base64::encode64(@day_home.email)})
    end
  end

  def contact
  
    params[:day_home_contact][:day_home_email] = Base64::decode64(params[:day_home_contact][:day_home_email])
    @day_home = DayHome.find(params[:id])
    @day_home_contact = DayHomeContact.new(params[:day_home_contact].merge(:day_home_id => @day_home.id))
        
    if @day_home_contact.save
      #redirect_to day_home_slug_path(@day_home.slug), :notice => "#{@day_home.name} has been contacted!"
      redirect_to followup_day_home_path(@day_home)
    else
      flash[:error]= "Something went wrong while sending your contact - please try again: "+@day_home_contact.errors.full_messages.to_sentence
      redirect_to day_home_slug_path(@day_home.slug)
    end
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
    if(current_user.agency_admin?)
      @day_home = current_user.agencies.first.day_homes.find(params[:id])
    else
      @day_home = current_user.day_homes.find(params[:id])
    end
  end
  
  def update
    if(current_user.agency_admin?)
      @day_home = current_user.agencies.first.day_homes.find(params[:id])
    else
      @day_home = current_user.day_homes.find(params[:id])
    end
    
    if @day_home.update_attributes(params[:day_home])
      redirect_to day_homes_path
    else
      render :action => :edit
    end
  end
  def followup  
    @day_home = DayHome.find(params[:id])
  end  
  
  private
  def sort_column
    DayHome.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"    
  end 
end

