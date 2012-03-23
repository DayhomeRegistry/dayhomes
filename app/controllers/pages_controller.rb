class PagesController < ApplicationController
  def index
    @featured_day_homes = DayHome.featured
  end
end