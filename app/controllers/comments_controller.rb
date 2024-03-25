class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @comments = Comment.order(created_at: :desc)
    render :index
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(params.require(:comment).permit(:body))
      flash[:success] = 'Comment was successfully updated.'
      redirect_to brew_hub_post_path(@comment.post)
    else
      flash.now[:error] = 'Unable to update Comment.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'Comment was successfully destroyed.'
    redirect_to brew_hub_post_path(@comment.post)
  end

  def edit
    @comment = Comment.find(params[:id])
    render :edit
  end
  
  def create
    # TODO: set to Post update
    @post = Post.find(params[:post_id])
    @replies = @post.comments
    @comment = @post.comments.new(params.require(:comment).permit(:body))
    current_user.comments << @comment
    if @comment.save
      flash[:success] = 'Comment was successfully created.'
      redirect_to brew_hub_post_path(@comment.post)
    else
      flash.now[:error] = 'Unable to create Comment.'
      puts @replies.ids
      render 'brew_hub/show', status: :unprocessable_entity
    end
  end

  def require_permission
    if Comment.find(params[:id]).user != current_user
      flash[:error] = 'You do not have permission to do that.'
      redirect_to comments_url
    end
  end
end
