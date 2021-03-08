class CommentsController < ApplicationController

  def new
    if params[:project_id] && @project = Project.find_by_id(params[:project_id])
      @comment = @project.comments.build
    else
      @comment = Comment.new
    end
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to comments_path
    else
      render :new
    end
  end

  def index
    if params[:project_id] && @project = Project.find_by_id(params[:project_id])
      @comments = @project.comments
    else
      @errors = flash[:message] = "That post doesn't exist." if params[:post_id]
      @comments = Comment.all
    end
  end

  def show
    @comment = Comment.find_by_id(params[:id])
  end

  def edit
    @comment = Comment.find_by_id(params[:id])
  end

  def update
    @comment = Comment.find_by(params[:id])
    if @comment.update(comment_params)
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :project_id)
  end
end
