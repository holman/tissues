#
# You are cheating:
#
# Things::Todo
#   status: open, completed
# Issue
#   state: open, closed
#

module Tissues
  module Sync
    include Octopi
    include Tissues::Helpers
    extend self
    
    def go!
      authenticated do
        local_todos = area.todos
        sync_back_to_github = []

        repository = Repository.find(:name => origin_path.split('/').last,
                                     :user => origin_path.split('/').first)
        repository.all_issues.each do |issue|
          if todo = Things::Todo.find(name_with_id(issue))
            todo.area = area
            if todo.completed? and issue.state.to_s == 'open'
              sync_back_to_github << todo
            else
              todo.status = issue.state.to_status
            end
            todo.notes = issue.body
            todo.save
            todo.reference.area.set(area.reference)
          else
            todo = Things::Todo.create(
              :name   => name_with_id(issue),
              :status => issue.state.to_status,
              :notes  => issue.body,
              :area   => area
            )
          end
          local_todos.reject!{|todo| todo.name == name_with_id(issue)}
        end

        local_todos.each do |todo|
          issue = Issue.open(
            :params => {
              :title => todo.name,
              :state => todo.status.to_s.to_state,
              :body => todo.notes
            },
            :repository => repository
          )
          todo.name = name_with_id(issue)
          todo.save
          todo.reference.area.set(area.reference) # resave area association
        end

        sync_back_to_github.each do |todo|
          issue = Issue.find(:repository => repository, :number => todo.number)
          (todo.status == 'open') ? issue.reopen! : issue.close!
        end
      end
    end

    def area
      return @area if defined? @area
      @area = Things::Area.find(origin_path) || 
              Things::Area.create(:name => origin_path)
    end
    
    def origin_path
      return @origin_path if defined? @origin_path
      @origin_path = `git remote -v | grep fetch`.
                      split(':').
                      last.
                      split('.git ').
                      first
    end

  end
end