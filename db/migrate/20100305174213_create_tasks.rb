class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|      
      t.string :title
      t.string :description
      t.integer :order_id
      t.boolean :is_completed
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
