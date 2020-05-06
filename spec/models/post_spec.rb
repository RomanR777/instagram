require 'rails_helper'

RSpec.describe Post, type: :model do
  context "validation" do
    let(:post) { build :post }
    let(:not_valid) { build :post, description: nil}

    it "valid" do
      expect(post).to be_valid
    end

    it "description presence" do
      expect(not_valid).to_not be_valid
    end
  end

  context "post scopes" do
    let(:user) { create :user }
    let(:user2) { create :user}

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

    it "get posts of followed users by user_id" do
      user.follow(user2)
      post = create(:post, user: user2)
      posts = Post.followed(user.id)
      expect(posts).to eq([post])
    end

  #
  #   it "posts of followed users will be first" do
  #     @user1.follow(@user2)
  #     post1 = create(:post, user: @user3, description: "Post by user3")
  #     post2 = create(:post, user: @user2, description: "Post by followed user")
  #     posts = Post.recent_followed_and_all(@user1.id)
  #     expect(posts[0].description).to eq("Post by followed user")
  #     TODO: exclude duplicated posts for followed users
  #     posts[1] - will be the save as post[0] !!!
      # expect(posts[2].description).to eq("Post by user3")
    # end
    #
    # it "get post count of followed users" do
    #   count_before = Post.followed_count(@user1.id)
    #   create(:post, user: @user2)
    #   count_after = Post.followed_count(@user1.id)
    #   expect(count_after - count_before).to eq(1)
    # end

  end
end
