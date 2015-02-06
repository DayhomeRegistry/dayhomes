class SearchesController < ApplicationController
  def index
    
    if params[:search].blank?
      @featured = DayHome.featured.all.reject{|x|!x.approved?}
      @day_homes = DayHome.with_availability_uniq(Search::DEFAULT_AVAILABILITY_TYPES).all.reject{|x| !x.approved?}
    else
      #debugger
      attributes = params[:search]

      if(!params["spots"].nil? && params["spots"].to_i>1)
        type = params["spots"].to_i
        # "availability_types":{"kind":["1","2","3","4","5","6","7","8"]}
        # <option value="1">All spots</option>
        # <option value="2">Full time</option> 1,2,3
        # <option value="3">Part time</option> 4,5,6,7,8
        # <option value="4">Before/After School</option> 2,3,7,8

        kinds = Hash.new
        if(type==2)
          kinds["kind"] = [1,2,3]
        elsif(type==3)
          kinds["kind"] = [4,5,6,7,8]
        else
          kinds["kind"] = [2,3,7,8]
        end
        attributes["availability_types"] = kinds
      end
      @search = Search.new(attributes)

      # If any errors, show an error message
      if @search.errors.count > 1
        flash.now[:error] = "Unable to find dayhomes within that criteria, please modifying the critera to be less restrictive"
      elsif @search.errors.count == 1
        flash.now[:error] = @search.errors[:base][0]
      end

      # set the pins for gmaps
      #@featured = DayHome.featured
      @day_homes = @search.day_homes
      @featured = @day_homes.reject {|dayhome| !dayhome.featured?}
    end

    # make sure the search object keeps its persistance
    @advanced_search = params.has_key?(:search) ? @search : Search.new
  end
  
end