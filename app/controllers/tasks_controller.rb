class TasksController < ApplicationController
  def index
    @tasks = Task.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  def show
    @task = Task.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      flash[:notice] = 'Task was successfully created.'
      redirect_to(@task)
    else
      render :action => "new"
    end
  end

  def new
    @task = Task.new
    respond_to do |format|
      format.html # new.html.erb
    end
     
  end
  def edit
  end
end