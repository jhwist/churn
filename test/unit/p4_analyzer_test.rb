require File.expand_path('../test_helper', File.dirname(__FILE__))

class P4AnalyzerTest < Test::Unit::TestCase
  context "P4Analyzer#get_logs" do
    should "return a list of changed files" 

    should "scope the changed files to an optional date range" 

    context "P4Analyzer#get_revisions" do
      should "return a list of changeset ids" 

      should "scope the changesets to an optional date range" 
    end

    context "P4Analyzer#get_updated_files_from_log(revision, revisions)" do
      should "return a list of modified files and the change hunks (chunks)" 
      should "return an empty array if it's the final revision"   
    end

    context "P4Analyzer#get_updated_files_change_info(revision, revisions)" do
      setup do
        @p4_analyzer = Churn::P4Analyzer.new
      end

      should "return all modified files with their line differences" 

      should "raise an error if it encounters a line it cannot parse" 

    end
  end
end
