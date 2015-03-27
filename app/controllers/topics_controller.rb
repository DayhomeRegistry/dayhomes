class TopicsController < ApplicationController
  before_filter :require_user_to_be_organization_admin
  before_filter :require_user_to_be_site_admin, :except => [:index, :show, :new, :create]

  def show
    @topic = Topic.find(params[:id])
    @topic.hit! if @topic
  end
  
  def new
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.new
  end
  
  def create
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.build(params[:topic])
    @topic.user = current_user
    
    if @topic.save
      flash[:success] = "Topic was successfully created."
      redirect_to topic_url(@topic)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:id])
    
    if @topic.update_attributes(params[:topic])
      flash[:success] = "Topic was updated successfully."
      redirect_to topic_url(@topic)
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    
    if @topic.destroy
      flash[:success] = "Topic was deleted successfully."
      redirect_to forum_url(@topic.forum)
    end
  end
end
