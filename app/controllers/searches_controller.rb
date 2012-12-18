class SearchesController < ApplicationController
  def index
    if params[:search].blank?
      @day_homes = DayHome.with_availability_uniq(Search::DEFAULT_AVAILABILITY_TYPES).all.reject{|x| !x.approved?}
    else
      #raise params.to_json
      @search = Search.new(params[:search])

      # If any errors, show an error message
      if @search.errors.count > 0
        flash.now[:error] = "Unable to find dayhomes within that criteria, please modifying the critera to be less restrictive"
      end

      # set the pins for gmaps
      @agency = Agency.find_by_id(@search.agency)
      @day_homes = @search.day_homes
    end

    # make sure the search object keeps its persistance
    @advanced_search = params.has_key?(:search) ? @search : Search.new
  end
  #def getInboundsMarkers
  #  bounds = paras[:bounds]
  #  
  #  respond_to do |format|
  #    format.js {
  #      render(:partial => "/searches/day_home", :locals => { :day_home => DayHome.within_bounds(bounds)})
  #    }
  #  end
  #end
end