class HomeController < ApplicationController
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

end
