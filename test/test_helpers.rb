require File.dirname(__FILE__) + '/test_helper'
include Octopi

context "Helpers" do
  include Tissues::Helpers
  
  test "name_with_id" do
    @issue = Issue.new(:title => 'nevernude', :number => 2)
    assert_equal '[#2] nevernude', name_with_id(@issue)
  end
  
  test "simple plural: singular" do
    assert_equal '1 nevernude', simple_plural(1,'nevernude')
  end
  
  test "simple plural: plural" do
    assert_equal '2 nevernudes', simple_plural(2,'nevernude')
  end
end