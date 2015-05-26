  $LOAD_PATH.unshift(File.dirname(__FILE__))

require "too_dead/version"
require 'too_dead/init_db'
require 'too_dead/user'
require 'too_dead/todo_list'
require 'too_dead/todo_item'

require 'pry'
require 'vedeu'

module TooDead
  class Menu
    # include Vedeu

    attr_reader :user, :todo_list, :todo_item

    def initialize
      @user = nil
      @todo_list = nil
      @todo_item = nil
    end

    def login(user_name)
      if TooDead::User.find_by(name: user_name) == nil
        puts "Your account was not found!"
        puts "A new account with username '#{user_name}' has been created."
      end
      @user = TooDead::User.find_or_create_by(name: user_name)
    end

    def access_list(list_name)
      @todo_list = @user.todo_lists.find_or_create_by(title: list_name)
    end

    def access_item(item_name, date = nil)
      @todo_item = @todo_list.todo_items.find_or_create_by(task_name: item_name)
    end

    def view_list
      available_list = @user.todo_lists.all
      if available_list[0] == nil
        puts "You do not have any current Todo Lists!"
        puts "Please create a new one:"
        list_title = gets.chomp
        access_list(list_title)
      else
        @user.list_menu
        choice = @user.list_choice
        if choice == "exit"
          run
        else
          access_list(choice)
        end
      end
    end

    ## Edits the item's due date

    def start
      puts "Welcome to the Todo-Listz!"
      puts "Please login with your username:"
      user_name = gets.chomp.downcase
    end

    def run
      user_name = start
      login(user_name)
      view_list
    end
  end
end




binding.pry
