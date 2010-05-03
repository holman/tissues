require File.dirname(__FILE__) + '/test_helper'

context "String" do
  test "to_state" do
    assert_equal :open, 'open'.to_state
    assert_equal :closed, 'closed'.to_state
  end
  
  test "to_status" do
    assert_equal :open, 'open'.to_status
    assert_equal :completed, 'closed'.to_status
  end
end

context "Things::Todo" do
  test "number parsed if present" do
    todo = Things::Todo.new(:name => '[#2] todo')
    assert_equal ['2'], todo.number
  end
  
  test "number ignored if not present" do
    todo = Things::Todo.new(:name => 'todo')
    assert_equal nil, todo.number
  end
end