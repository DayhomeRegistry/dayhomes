class ApplicationController < ActionController::Base
  before_filter :create_search
  protect_from_forgery

  def create_search
    @search = Search.new
  end

end
