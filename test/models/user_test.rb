require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "smoke test" do
    assert_equal 1, User.count
  end
end
