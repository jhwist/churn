require File.expand_path('../test_helper', File.dirname(__FILE__))
require 'churn/p4_analyzer'

class P4AnalyzerTest < Test::Unit::TestCase
  context "P4Analyzer#get_logs" do
    setup do
      @p4_analyzer = Churn::P4Analyzer.new
      @p4_analyzer.stubs(:p4_list_changes).returns(
        "Change 62660 on 2005/11/28 by x@client 'CHANGED: adapted to DESCODE '
Change 45616 on 2005/07/12 by x@client 'ADDED: trigger that builds and '
Change 45615 on 2005/07/12 by x@client 'ADDED: for testing purposes '
Change 45614 on 2005/07/12 by x@client 'COSMETIC: updated header '
Change 11250 on 2004/09/17 by x@client 'CHANGED: trigger now also allow'
Change 9250 on 2004/08/20 by x@client 'BUGFIX: bug#1583 (People can so'
Change 5560 on 2004/04/26 by x@client 'ADDED: The \"BRANCHED\" tag.'"
      )
      @p4_analyzer.stubs(:p4_describe_change).with("5560").returns(
        "Change 5560 by x@client on 2004/04/26 17:25:03

        ADDED: The \"BRANCHED\" tag.

Affected files ...

... //admin/scripts/triggers/enforce-submit-comment.py#2 edit
... //admin/scripts/triggers/check-consistency.py#3 edit

Differences ...

==== //admin/scripts/triggers/enforce-submit-comment.py#2 (ktext) ====

add 1 chunks 1 lines
deleted 0 chunks 0 lines
changed 1 chunks 3 / 3 lines

==== //admin/scripts/triggers/check-consistency.py#3 (ktext) ====

add 0 chunks 0 lines
deleted 0 chunks 0 lines
changed 1 chunks 3 / 1 lines"
      )

    end
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

    context "Perforce commands" do
      setup do
        @p4_analyzer = Churn::P4Analyzer.new
        @p4_analyzer.stubs(:p4_list_changes).returns(
          "Change 62660 on 2005/11/28 by x@client 'CHANGED: adapted to DESCODE '
Change 45616 on 2005/07/12 by x@client 'ADDED: trigger that builds and '
Change 45615 on 2005/07/12 by x@client 'ADDED: for testing purposes '
Change 45614 on 2005/07/12 by x@client 'COSMETIC: updated header '
Change 11250 on 2004/09/17 by x@client 'CHANGED: trigger now also allow'
Change 9250 on 2004/08/20 by x@client 'BUGFIX: bug#1583 (People can so'
Change 5560 on 2004/04/26 by x@client 'ADDED: The \"BRANCHED\" tag.'"
        )
        @p4_analyzer.stubs(:depot_to_local).with("//admin/scripts/triggers/enforce-submit-comment.py")\
          .returns("triggers/enforce-submit-comments.py")
        @p4_analyzer.stubs(:depot_to_local).with("//admin/scripts/triggers/check-consistency.py")\
          .returns("triggers/check-consistency.py")   
        @p4_analyzer.stubs(:p4_describe_change).with("5560").returns(
          "Change 5560 by x@client on 2004/04/26 17:25:03

        ADDED: The \"BRANCHED\" tag.

Affected files ...

... //admin/scripts/triggers/enforce-submit-comment.py#2 edit
... //admin/scripts/triggers/check-consistency.py#3 edit

Differences ...

==== //admin/scripts/triggers/enforce-submit-comment.py#2 (ktext) ====

add 1 chunks 1 lines
deleted 0 chunks 0 lines
changed 1 chunks 3 / 3 lines

==== //admin/scripts/triggers/check-consistency.py#3 (ktext) ====

add 0 chunks 0 lines
deleted 0 chunks 0 lines
changed 1 chunks 3 / 1 lines"
        )

      end
      should "lists changenumbers from parsing 'p4 changes' output" do
        assert_equal(%w[62660 45616 45615 45614 11250 9250 5560],@p4_analyzer.changes)
      end
      should "lists files per changenumber" do
        assert_equal( [[4,"triggers/enforce-submit-comments.py"],
                     [1,"triggers/check-consistency.py"]], @p4_analyzer.files_per_change("5560"))
      end
    end
  end
end
