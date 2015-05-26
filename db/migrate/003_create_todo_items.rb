class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string    :task_name
      t.text      :description
      t.date      :due_date
      t.boolean   :completed?, :default => false 
    end
  end
end