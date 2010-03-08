class Task < ActiveRecord::Base

  #=================================================================================
  #  * Method name: get_task_lists
  #  * Input: page, per_page
  #  * Output: task lists
  #  * Date created: March 05, 2010
  #  * Developer: ChonDM
  #  * Last Changed : 
  #  * Description: get task lists
  #=================================================================================
  
  def self.get_task_lists(page,per_page)
    tasks = paginate :page => page, 
                     :per_page => per_page
  end
end
