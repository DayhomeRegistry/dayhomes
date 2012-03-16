class SearchesController < ApplicationController

  def index
    # user goes directy to index page without search params
    if params[:search].blank?
      # display all of the full and part time
      @day_homes = DayHome.joins(:day_home_availability_types, :availability_types)
        .where("availability_types.kind IN (?)", ['Full-time', 'Part-time']).group("day_homes.id").all.to_gmaps4rails
    else
      search_model = Search.new(params[:search])
      # determine which dayhomes to display
      @day_homes = search_model.dayhome_filter(params)
    end

    # make sure the search object keeps its persistance
    @advanced_search = params.has_key?(:search) ? Search.new(params[:search]) : Search.new
  end
end