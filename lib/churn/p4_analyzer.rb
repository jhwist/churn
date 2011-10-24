module Churn

  #analizes Bzr / Bazaar SCM to find recently changed files, and what lines have been altered
  class P4Analyzer < SourceControl
    def get_logs
    end

    def get_revisions
    end

    private

    def get_diff(revision, previous_revision)
    end

    def date_range
      if @start_date
        date = Chronic.parse(@start_date)
        "-r #{date.strftime('%Y-%m-%d')}.."
      end
    end

    def get_recent_file(line)
      super(line).split("\t")[0]
    end

  end
end
