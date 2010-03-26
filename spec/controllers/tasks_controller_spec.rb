require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TasksController do 
  
  def mock_task(stubs={})
    @mock_task ||= mock_model(Task, stubs)
  end
  
  describe "handling GET/ tasks" do
    it "get all list tasks" do
      page = 1
      per_page = 10
      object_paginate = mock("will_paginate")
      Task.stub(:get_task_lists).with(page,per_page).and_return(object_paginate) 
      get :index 
      assigns[:tasks].should == object_paginate  
      response.should render_template('tasks/index')
    end 
  end 
  
  describe 'GET show' do
    before do
      Task.stub(:find_by_id).with('10').and_return(mock_task)
      get :show, :id => 10
    end
    it "assigns the requested job as @task" do
      assigns[:task].should == mock_task
    end

  end
  
  describe "Creating a new task" do
    before(:each) do
      @attributes = {'title' => "A", 'description' => 'create database'}
      @task = mock_model(Task)
      Task.should_receive(:new).with(@attributes).once.and_return(@task)
      
    end
    it 'should redirect to index with a notice on successful save' do
      @task.should_receive(:save).with().once.and_return(true)        
      post :create, :task => @attributes        
      assigns[:task].should be(@task)
      flash[:notice].should_not be(nil)    
      response.should redirect_to(tasks_url)
    end      
    it 'should re-render new template on failed save' do
      @task.should_receive(:save).with().once.and_return(false)
      post :create, :task => @attributes
      assigns[:task].should be(@task)
      flash[:notice].should be(nil)    
      response.should be_success
      response.should render_template('new')
    end
 end

  describe "PUT update" do
     
    context 'with valid params' do
      it 'updates the requested task' do
        Task.should_receive(:find).with('10').and_return(mock_task)          
        mock_task.should_receive(:update_attributes).with({'title' => 'BB'})
        put :update, :id => 10, :task => {:title => 'BB'}
      end
      it 'assigns the requested task as @task' do
        Task.stub!(:find).and_return(mock_task({:update_attributes => true}))
        put :update, :id => 10
        assigns[:task].should == mock_task
      end
      it 'redirects to the task' do
        Task.stub!(:find).and_return(mock_task({:update_attributes => true}))
        put :update, :id => 42
        response.should redirect_to(task_path(mock_task))
      end
    end 
      
    context 'with invald params' do
      it 'updates the requested task' do
        Task.should_receive(:find).with('10').and_return(mock_task)          
        mock_task.should_receive(:update_attributes).with({'title' => 'BB'})
        put :update, :id => 10, :task => {:title => 'BB'}
      end
      it 'assigns the requested task as @task' do
        Task.stub!(:find).and_return(mock_task({:update_attributes => false}))
        put :update, :id => 10
        assigns[:task].should == mock_task
      end
      it 'redirects to the task' do
        Task.stub!(:find).and_return(mock_task({:update_attributes => false}))
        put :update, :id => 42
        response.should render_template('edit')
      end
    end
  end
  
  describe 'GET edit' do
    before(:each) do
      Task.stub(:find).with('10').and_return(mock_task)
    get :edit, :id => 10
    end
    it "assigns the requested task as @task" do    
     assigns[:task].should == mock_task
    end
    it 'should not redirect' do
      response.should_not be_redirect
    end
    it 'should render the edit template' do
      response.should render_template(:edit)
    end 
  end  

  describe 'DELETE destroy' do
    it "destroys the requested task" do       
     task = Task.stub!(:find).with('10').and_return(mock_task)       
     mock_task.should_receive(:destroy) 
     delete :destroy, :id => 10
    end

    it 'redirects to /tasks' do
      Task.stub!(:find).and_return(mock_task({:destroy => true}))
      delete :destroy, :id => 10
      flash[:notice].should_not be(nil)
      response.should redirect_to(tasks_url)
    end
  end
end
