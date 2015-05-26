module TooDead
  class User < ActiveRecord::Base
    has_many :todo_lists, :dependent => :destroy

    def delete_user
      self.destroy
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
  end
end
