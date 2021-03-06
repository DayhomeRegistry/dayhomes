class PostsController < ApplicationController
  before_filter :require_user_to_be_organization_admin

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    
    if params[:quote]
      quote_post = Post.find(params[:quote])
      if quote_post
        @post.body = "[quote]#{quote_post.body}[/quote]"
      end
    end
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(params[:post])
    @post.forum = @topic.forum
    @post.user = current_user
    
    if @post.save
      flash[:success] = "Post was successfully created."
      redirect_to topic_path(@post.topic)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])

    if @post.user_id == current_user.id
      if @post.update_attributes(params[:post])
        flash[:success] = "Post was successfully updated."
        redirect_to topic_path(@post.topic)
      end
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    
    if @post.topic.posts_count > 1
      if @post.destroy
        flash[:success] = "Post was successfully destroyed."
        redirect_to topic_path(@post.topic)
      end
    else
      if @post.topic.destroy
        flash[:success] = "Topic was successfully deleted."
        redirect_to forum_path(@post.forum)
      end
    end
  end

end