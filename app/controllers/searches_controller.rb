class SearchesController < ApplicationController

  def index
    # user goes directy to index page without search params
    if params[:search].blank?
      # display all of the full and part time
      @day_homes = DayHome.joins(:availability_types)
        .where("availability_types.kind IN (?)", ['Full-time', 'Part-time']).group("day_homes.id").all.to_gmaps4rails
    else
      # apply the params to the search model
      search_model = Search.new(params[:search])

      # determine which dayhomes to display
      search_model.dayhome_filter(params[:search])

      # If any errors, show an error message
      if search_model.errors.count > 0
        flash.now[:error] = "Unable to find dayhomes within that criteria"
      end

      # set the pins for gmaps
      @day_homes = search_model.pin_json
    end

    # make sure the search object keeps its persistance
    @advanced_search = params.has_key?(:search) ? Search.new(params[:search]) : Search.new
  end
end