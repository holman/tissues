require File.dirname(__FILE__) + '/test_helper'

context "syncing" do
  test "github_repo is the git remote" do
    Tissues::Sync.stubs(:different_remote?).returns(false)
    Tissues::Sync.stubs(:cmd).with('git remote -v | grep fetch').returns('holman/dotfiles')
    assert_equal 'holman/dotfiles', Tissues::Sync.github_repo
  end
  
  test "github_repo is overriden" do
    Tissues::Sync.stubs(:different_remote?).returns(true)
    path = "zachholman/dotfiles\n"
    path.stubs(:readline).returns(path)
    File.stubs(:new).returns(path)
    assert_equal 'zachholman/dotfiles', Tissues::Sync.github_repo
  end
end