class SearchesController < ApplicationController
  def index
    if params[:search].blank?
      @day_homes = DayHome.with_availability_uniq(Search::DEFAULT_AVAILABILITY_TYPES).all.reject{|x| !x.approved?}
    else
      #raise params.to_json
      @search = Search.new(params[:search])

      # If any errors, show an error message
      debugger
      if @search.errors.count > 1
        flash.now[:error] = "Unable to find dayhomes within that criteria, please modifying the critera to be less restrictive"
      elsif @search.errors.count == 1
        flash.now[:error] = @search.errors[:base][0]
      end

      # set the pins for gmaps
      @day_homes = @search.day_homes
    end

    # make sure the search object keeps its persistance
    @advanced_search = params.has_key?(:search) ? @search : Search.new
  end
  
end