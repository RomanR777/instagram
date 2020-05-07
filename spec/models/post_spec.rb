require 'rails_helper'

RSpec.describe Post, type: :model do
  context "validation" do
    let(:post) { build :post }
    let(:not_valid) { build :post, description: nil }

    it "valid" do
      expect(post).to be_valid
    end

    it "description presence" do
      expect(not_valid).to_not be_valid
    end
  end

  context "posts filtering" do
    let(:user) { create :user }
    let(:user2) { create :user }

    it "get posts by user nickname" do
      post = create(:post, user: user)
      posts = Post.by_nickname(user.nickname)
      expect(posts).to eq([post])
    end

    it "get posts which user likes" do
      post = create(:post, user: user)
      create(:like, post: post, user: user2)
      posts = Post.liked(user2.id)
      expect(posts).to eq([post])
    end
  end

  context "followed" do
    let(:user) { create :user }
    let(:user2) { create :user }
    let!(:follow) { user.follow(user2) }

    it "get all posts from follow" do
      post = create(:post, user: user2)
      posts = Post.followed(user.id)
      expect(posts).to eq([post])
    end

    it "count all posts from follow" do
      create(:post, user: user2)
      followed_count = Post.followed_count(user.id)
      expect(followed_count).to eq(1)
    end

    it "get recent posts from follow" do
      recent_post = create(:post, user: user2, created_at: DateTime.now)
      old_post = create(:post, user: user2, created_at: DateTime.now - 2.days)
      posts = Post.recent_followed(user.id)
      expect(posts).to eq([recent_post])
    end

    it "count recent posts from follow" do
      create(:post, user: user2, created_at: DateTime.now)
      create(:post, user: user2, created_at: DateTime.now - 2.days)
      recent_post_count = Post.recent_followed_count(user.id)
      expect(recent_post_count).to eq(1)
    end
  end

  describe "Post#recent_followed_and_all" do
    it "returns followed posts first" do
      user1, user2, user3 = create(:user), create(:user), create(:user)
      user1.follow(user2)
      recent_followed_post = create(:post, user: user2)
      old_followed_post = create(:post, user: user2, created_at: DateTime.now() - 2.days)
      not_followed_post = create(:post)
      expectation = [recent_followed_post, not_followed_post,
                     recent_followed_post, old_followed_post]
      posts = Post.recent_followed_and_all(user1.id)
      expect(posts).to eq(expectation)
    end
  end
end
