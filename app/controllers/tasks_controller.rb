class TasksController < ApplicationController
   #No
  PER_PAGE = 10

  def index
    @page = params[:page] || 1
    @per_page = PER_PAGE
    @tasks = Task.get_task_lists(@page,@per_page)
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show  
    unless @task = Task.find_by_id(params[:id])
      redirect_to root_path   
    end
  end
   # POST /tasks
  def create
    task = params[:task]    
    @task = Task.new(params[:task]) 
    puts @task   
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        redirect_to(tasks_url)
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
    if @task.destroy 
        # don't task should be handled after this task 
      flash[:notice] = "Task was successfully deleted."
    else
       flash[:notice] = "Task wasn't successfully deleted. Because orther task should be handled after that is not completed"
    end  
    redirect_to(tasks_url)
  end
   # PUT /tasks/1
  def update
    @task = Task.find(params[:id])  
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        redirect_to(@task)
      else
        render :action => "edit"
      end
   
  end
end
