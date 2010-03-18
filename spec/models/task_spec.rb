require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "--Message" do
  before(:each) do
    @task = Task.new(:title => "A" , :description => "create database" )
  end

  it "is valid with valid attributes" do
    @task.should be_valid
  end
  
  it "is not valid without a title" do
    @task.title = nil
    @task.should_not be_valid
  end
  
  it "is not valid without a description" do
    @task.description = nil
    @task.should_not be_valid
  end
  
  it "length of title > 100 character" do    
    Task.new(
            :title => "This pattern splits the view (also called the presentation) into dumb templates
that are primarily responsible inserting pre-built data  between HTML tags.
The model contains the smart domain objects", 
            :description => "create database").should_not be_valid
  end
end

describe "--Function get_task_lists" do
  it "Should have task objects" do
    page = 1
    perpage = 10
    task_ob = mock('A task obkject')
    Task.should_receive(:paginate).with(:page => page, :per_page => perpage).and_return(task_ob)
    (Task.get_task_lists(page,perpage) == task_ob).should be_true
  end
end

describe '--Function check task before delete ' do
  it "Case 1: Task A handled after task B but task A not complete" do
    task_id = 1
    task = mock("A task object")
    task.stub!(:id).and_return(task_id)    
    Task.should_receive(:find).with(:first, :conditions =>["order_id =? and is_completed = ?",task.id,0]).and_return(task)
    (Task.check_task_before_delete(task.id) == task).should be_true
  end
  
  it "Case 2: Task A handled after task B and task A complete" do
    task_id = 1
    task = mock("A task object")
    task.stub!(:id).and_return(task_id)    
    Task.should_receive(:find).with(:first, :conditions =>["order_id =? and is_completed = ?",task.id,0]).and_return(nil)
    (Task.check_task_before_delete(task.id) == nil).should be_true
  end
end


