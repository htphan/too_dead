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

    def list_choice
      puts "Please select a list by entering it's name,"
      puts "  or create a new list by entering a new title name,"
      puts "  or write 'exit' to leave:"
      choice = gets.chomp
    end

    def list_interaction
      puts "What would you like to do with your list?"
      puts "1: View Items \n2: Edit Title \n3: Remove \n4: Exit"
      choice = gets.chomp
      until choice =~ /^[1234]$/
        puts "Please enter 1, 2, 3, or 4:"
        choice = gets.chomp
      end
      if choice == "1"
        view_items
      elsif choice == "2"
        edit_list_title
      elsif choice == "3"
        puts "!!!WARNING!!! \nAll items associated with this will be deleted as well!"
        puts "Are you sure you want to delete this list? (y/n)"
        answer = gets.chomp.downcase
        until answer =~ /^[yn]$/
          puts "Please enter Yes (y) or No (n):"
          answer = gets.chomp.downcase
        end
        if answer == "y"
          delete_list
          puts "Your list was deleted!"
          view_list
        else
          view_list
        end
      else
        view_list
      end
    end

    def item_interaction
      puts "What would you like to do with your current tasks?"
      puts "1: Access/Create a task \n2: Return to list"
      choice = gets.chomp
      until choice =~ /^[12]$/
        puts "Please enter '1' or '2':"
        choice = gets.chomp
      end
      if choice == "1"
        puts "Please input the name of the task you wish to access/create:"
      else
        view_list
      end
    end
  end
end
