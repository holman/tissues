module Tissues
  module Helpers
    def name_with_id(issue)
      "[##{issue.number}] #{issue.title}"
    end
  end
end