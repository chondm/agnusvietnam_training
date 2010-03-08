class TasksController < ApplicationController
  
  def show
    unless @task = Task.find_by_id(params[:id])   
      redirect_to root_path   
    end
  end
   # POST /tasks
  def create
    @task = Task.new(params[:task])
    if @task.save
      flash[:notice] = 'Task was successfully created.'
      redirect_to(@task)
    else
      render :action => "new"
    end
  end
  # GET /tasks/new
  def new
    @task = Task.new    
    respond_to do |format|
      format.html # new.html.erb
    end
     
  end
  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to(home_url)
  end
   # PUT /tasks/1
  def update
    @task = Task.find(params[:id])    
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Post was successfully updated.'
        redirect_to(@task)
      else
        frender :action => "edit"
      end
   
  end
end
