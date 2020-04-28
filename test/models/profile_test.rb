require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test "test profiles" do
    assert_equal 3, Profile.count
  end

  test "following" do
    star = Profile.find(1)
    follower1 = Profile.find(2)
    follower2 = Profile.find(3)
    star.followers << follower1
    star.followers << follower2
    assert_equal 2, star.followers.count
  end

  test "posts for followed profiles" do
    follower = Profile.find(3)

    followed1 = Profile.find(1)
    followed2 = Profile.find(2)

    byebug
    followed1.followed << follower
    followed2.followed << follower

    assert_equal 4, follower.followed.posts.count
  end
end
