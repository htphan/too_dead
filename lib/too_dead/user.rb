module TooDead
  class User < ActiveRecord::Base
    has_many :todo_lists, :dependent => :destroy

    def delete_user
      self.destroy
    end

    def view_list
      available_list = self.todo_lists.all
      if available_list[0] == nil
        puts "You do not have any current Todo Lists!"
        puts "Please create a new one:"
        list_title = gets.chomp
        access_list(list_title)
      else
        list_menu
        choice = list_choice
        if choice == "exit"
          run
        else
          access_list(choice)
        end
      end
    end

    def list_menu
      puts "Here are your availabe Todo Lists:"
      puts "Title -> Date Created"
      self.todo_lists.order(created_at: :desc).each do |l|
        title = l.title
        created_date = l.created_at.to_date
        puts "#{title} -> #{created_date}"
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
