module Churn

  #analyzes Perforce SCM to find recently changed files, and what lines have been altered
  class P4Analyzer < SourceControl

    def get_logs
    end

    def get_revisions
    end

    def changes(start_date = "")
      rev_range = ""
      if not start_date == ""
        rev_range = "#{start_date},#{Time.now.strftime("%Y/%m/%d")}"
      end
      p4_list_changes(rev_range).each_line.map do |change|
        change.match(/Change (\d+)/)[1]
      end
    end

    def files_per_change(change)
      describe_output = p4_describe_change(change).split("\n")
      map = []
      describe_output.each_index do |index|
        if describe_output[index].start_with?("====")
          fn = depot_to_local(describe_output[index].match(/==== (\/\/.*)#\d+/)[1])
          #churn = sum_of_changes(describe_output[index .. index + 4].join("\n"))
          map << fn
        end
      end
      return map
    end

    def sum_of_changes(p4_describe_output)
      churn = 0
      p4_describe_output.each_line do |line|
        next unless line =~ /(add|deleted|changed) .* (\d+) lines/
          churn += line.match(/(\d+) lines/)[1].to_i
      end
      return churn
    end

    def depot_to_local(depot_file)
      abs_path =  p4_fstat(depot_file).each_line.select {
        |line| line =~ /clientFile/
      }[0].split(" ")[2].tr("\\","/")
      Pathname.new(abs_path).relative_path_from(Pathname.new(FileUtils.pwd)).to_s
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

    def p4_list_changes(rev_range = "") 
      `p4 changes -s submitted @#{rev_range}`
    end

    def p4_describe_change(change)
      `p4 describe -ds #{change}`
    end

  end
end
