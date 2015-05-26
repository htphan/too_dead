module TooDead
  class TodoList < ActiveRecord::Base
    belongs_to  :user
    has_many    :todo_items, :dependent => :destroy

    def delete_list
      self.destroy
    end

    def edit_list_title
      puts "What will be the new title for your list?"
      new_title = gets.chomp
      self.update(title: new_title)
    end

    def view_items
      @completed = self.todo_items.where(completed?: true)
      @incomplete = self.todo_items.where(completed?: false)
      @overdue = self.todo_items.where("due_date < ?", Time.now.to_date)
      puts "How would you like to view your items?"
      puts "1: Incomplete \n2: Complete \n3: Overdue \n4: Exit"
      choice = gets.chomp
      until choice =~ /^[1234]$/
        puts "Please choose 1, 2, 3, 4:"
        choice = gets.chomp
      end
      if choice == "1"
        incomplete_items
      elsif choice == "2"
        completed_items
      elsif choice == "3"
        overdue_items
      else
       ## view_list
      end
    end

    def completed_items
      puts "Here are your completed tasks:"
      if @completed[0] == nil
        puts "You dont have any completed tasks!"
        puts "For shame! Go back to your list!"
        ## list_menu
      else 
        puts "Task Name -> Description -> Due Date -> Completed"
        @completed.each do |x|
          puts "#{x.task_name} -> #{x.description} -> "\
            "#{x.due_date} -> #{x.completed?}"
        end
      end
    end

    def incomplete_items
      puts "Here are your incomplete tasks:"
      if @incomplete[0] == nil
        puts "You dont have any incomplete tasks!"
        puts "Congratulations! Let's get you back to the main list!"
        list_menu
      else 
        puts "Task Name -> Description -> Due Date -> Completed"
        @incomplete.each do |x|
          puts "#{x.task_name} -> #{x.description} -> "\
            "#{x.due_date} -> #{x.completed?}"
        end
      end
    end

    def overdue_items
      puts "Here are your overdue tasks:"
      if @overdue[0] == nil
        puts "You dont have any incomplete tasks!"
        puts "Congratulations! Let's get you back to the main list!"
        view_list
      else 
        puts "Task Name -> Description -> Due Date -> Completed"
        @overdue.each do |x|
          puts "#{x.task_name} -> #{x.description} -> "\
            "#{x.due_date} -> #{x.completed?}"
        end
      end
    end


  end
end
