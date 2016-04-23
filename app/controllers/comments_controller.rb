class CommentsController < ApplicationController
  before_action :find_post
  
  def index
    @comments = @post.comments.all.order("created_at DESC")
    
    respond_to do |format|
      format.html
      format.json {render json: @comments}
      format.js
    end
  end
  
  def create
    @comment = @post.comments.create(comment_params)
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: "New comment created."}
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new"}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end
  
  def destroy
    @comment = @post.comments.destroy
    
    respond_to do |format|
      format.html { redirect_to @post }
      format.json { head :ok }
      format.js
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
  def find_post
    @post = Post.find(params[:post_id])
  end
end