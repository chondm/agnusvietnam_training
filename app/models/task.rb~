class Task < ActiveRecord::Base
  validates_presence_of:title,:description 
  validates_length_of:title, :maximum => 255 
  
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
  
  #=================================================================================
  #  * Method name: check_task_before_delete
  #  * Input: page, per_page
  #  * Output: task lists
  #  * Date created: March 013, 2010
  #  * Developer: ChonDM
  #  * Last Changed : 
  #  * Description: Checking this task have task order after
  #=================================================================================
  def self.check_task_before_delete(id)
    ret = Task.find(:first, :conditions => ["order_id =? and is_completed = ?",id,0])
    return ret
  end
end
