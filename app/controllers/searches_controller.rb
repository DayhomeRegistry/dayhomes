class SearchesController < ApplicationController

  def index
    # user goes directy to index page without search params
    if params[:search].blank?
      # display all of the full and part time
      @day_homes = DayHome.with_availability_uniq(['Full-time', 'Part-time']).all
    else
      # apply the params to the search model
      @search = Search.new(params[:search])

      # If any errors, show an error message
      if @search.errors.count > 0
        flash.now[:error] = "Unable to find dayhomes within that criteria, please modifying the critera to be less restrictive"
      end

      # set the pins for gmaps
      @day_homes = @search.dayhomes
    end

    # make sure the search object keeps its persistance
    @advanced_search = params.has_key?(:search) ? @search : Search.new
  end
end