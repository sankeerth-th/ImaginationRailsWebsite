class BrewHubController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: [:show, :reply, :edit, :update, :destroy]
  
    # GET /brew_hub
    # Display all posts in the Brew Hub
    def index
      @posts = Post.all # Fetches all posts. Adjust as per your Post model
    end
  
    # GET /brew_hub/posts/:id
    # Show a specific post
    def show
      # @post is set by set_post method
      # Optionally, you can fetch replies for the post if you have a Reply model
      @replies = @post.comments # Assumes a has_many relationship in Post model
      @comment = Comment.new
    end
  
    # POST /brew_hub/posts/:id/reply
    # Handle reply to a post
    def reply
      # Create a reply for the post
      # This assumes you have a Reply model with fields like user_id, post_id, content
      @reply = @post.replies.build(reply_params)
      @reply.user = current_user # Assumes you have a method to get the currently logged-in user
  
      if @reply.save
        # Redirect back to the post with a success message
        redirect_to brew_hub_post_path(@post), notice: 'Reply was successfully posted.'
      else
        # If saving fails, re-render the 'show' template to display errors
        render :show
      end
    end

    def new
        @post = Post.new  # Assuming you have a Post model
    end
    
    def create
        @post = Post.new(post_params)
        @post.user = current_user  # Associate the post with the current user
      
        if @post.save
          redirect_to brew_hub_path, notice: 'Post was successfully created.'
        else
          render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
        redirect_to brew_hub_path, alert: 'Not authorized' unless @post.user == current_user
        render :edit
    end
      
    def update
        @post = Post.find(params[:id])
        if @post.update(params.require(:post).permit(:title, :content))
          redirect_to brew_hub_path, notice: 'Post was successfully updated.'
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def new_reply
        @post = Post.find(params[:post_id])
        @reply = Reply.new  # Assuming you have a Reply model
        # Ensure here that @reply is associated with @post
    end

    def destroy
      # Ensuring only the post owner can delete the post
      if @post.user == current_user
        @post.destroy
        redirect_to brew_hub_path, notice: 'Post was successfully deleted.'
      else
        redirect_to brew_hub_path, alert: 'You are not authorized to delete this post.'
      end
    end

    def view_post
      @post = Post.find(params[:id])
      @replies = @post.comments.order('created_at DESC') # or your logic for latest replies
    end
      
      
  
    private
  
    # Use callbacks to share common setup or constraints between actions
    def set_post
      @post = Post.find(params[:id]) # Finds the post by id
    end
  
    # Only allow a list of trusted parameters through for replies
    def reply_params
      params.require(:reply).permit(:content) # Adjust according to your Reply model
    end

    def post_params
        params.require(:post).permit(:title, :content, :images)  # Update these attributes based on your Post model
    end
  end
  