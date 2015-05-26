module TooDead
  class TodoItem < ActiveRecord::Base
    belongs_to :todo_list

    def delete_item
      self.destroy
    end

    def edit_item_description
      puts "What is your item's description?"
      new_description = gets.chomp
      self.update(description: new_description)
    end

    def edit_item_due
      puts "What is your item's due date/time?"
      puts "(A time is not required if not needed)"
      puts "Please use this format (DD/MM/YYYY):"
      new_due = gets.chomp
      until new_due =~ /^(([0-2]\d|[3][0-1])\/([0]\d|[1][0-2])\/[2][0]\d{2})$/
        puts "Please follow this format 'DD/MM/YYYY':"
      end
      self.update(due_date: new_due)
    end

    def edit_item_complete
      puts "Did you complete your task? (y/n)"
      response = gets.chomp.downcase
      until response =~ /^[yn]$/
        puts "I said Yesy(y) or No(n)..."
        response = gets.chomp.downcase
      end
      if response == "y"
        self.update(completed?: true)
      end
    end
  end
end
