class CommentsController < ApplicationController

  def create
    @comment = Comment.new
    @project = Project.find(params[:project_id])
    @comment.project_id = params[:project_id]
    @comment.user_id = current_user.id
    @comment.comment = params[:comment][:message]

    if @comment.save
      redirect_to project_url(@project)
      flash[:alert] = "You have successfully added a comment."
    else
      flash[:alert] = "Sorry, we are unable to save your comment."
      render "projects/show"
    end
  end

  def edit
  end

  def update
  end

  def destroy

  end


end
