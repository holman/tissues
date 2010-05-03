module Tissues
  module Helpers
    def name_with_id(issue)
      "[##{issue.number}] #{issue.title}"
    end
    
    def simple_plural(count,singular)
      if count == 1
        "#{count} #{singular}"
      else
        "#{count} #{singular}s"
      end
    end
  end
end