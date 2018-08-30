class PledgesController < ApplicationController
  before_action :require_login

  def create
    @project = Project.find(params[:project_id])

    @pledge = Pledge.new
    @pledge.project = @project
    @pledge.dollar_amount = params[:pledge][:dollar_amount]
    @pledge.user = current_user

    if @pledge.save
      redirect_to project_url(@project), notice: "You have successfully backed #{@project.title}!"
    else
      @comment = Comment.new
      flash.now[:alert] = @pledge.errors.full_messages.first
      render 'projects/show'
    end
  end

end
