class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  before_action :require_ownership, only: [:edit, :update]


  def index
    @projects = Project.all
    @projects = @projects.order(:end_date)
  end

  def show
    @project = Project.find(params[:id])
    # @pledge = @project.pledges
    # @backer = @project.users
  end

  def new
    @project = Project.new
    @project.rewards.build
  end

  def create
    @project = Project.new
    @project.title = params[:project][:title]
    @project.description = params[:project][:description]
    @project.goal = params[:project][:goal]
    @project.start_date = params[:project][:start_date]
    @project.end_date = params[:project][:end_date]
    @project.image = params[:project][:image]
    @project.user = current_user # => save the user id to the project on create

    if @project.save
      redirect_to projects_url
    else
      render :new
    end
   end

end
