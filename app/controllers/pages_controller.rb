class PagesController < ApplicationController
  def index
    @featured_day_home = DayHome.featured.first(:offset => rand(DayHome.featured.count))
  end
end