class CategoriesController < ApplicationController
  before_filter :require_user_to_be_site_admin, :except => [:index]
  before_filter :require_user_to_be_organization_admin

  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    
    if @category.save
      flash[:notice] = "Category was successfully created."
      redirect_to forums_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    
    if @category.update_attributes(params[:category])
      flash[:success] = "Category was updated successfully."
      redirect_to forums_url
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    
    if @category.destroy
      flash[:success] = "Category was deleted."
      redirect_to forums_url
    end
  end

  private 
  def category_params
    params.require(:category).permit(:title, :state, :position, :category_id)
  end
end