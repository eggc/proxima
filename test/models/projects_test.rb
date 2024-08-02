require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "project fixture" do
    assert(5, Project.count)
    assert(1, Character.count)
  end
end
