require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user = build(:user)
    @post = build(:post, user: @user)

    @user1 = create(:user)
    @user2 = create(:user, nickname: "user2", id: 2, email: "user2@user2.com")
    @user3 = create(:user, nickname: "user3", id: 3, email: "user3@user3.com")

    @post1 = create(:post, user: @user1)
    @post2 = create(:post, user: @user2)
    create(:like, post_id: @post2.id, user_id: @user1.id)
  end

  context "validation" do
    it "valid" do
      expect(@post).to be_valid
    end

    it "description presence" do
      post2 = build(:post, description: nil)
      expect(post2).to_not be_valid
    end
  end

  context "post scopes" do
    it "get post by user id" do
      posts = Post.by_id(1)
      expect(posts).not_to be_empty
    end

    it "get posts by user id" do
      posts = Post.by_nickname("user1")
      expect(posts).not_to be_empty
    end

    it "get posts by user nickname" do
      posts = Post.by_nickname("user1")
      expect(posts).not_to be_empty
    end

    it "get posts by user nickname count" do
      posts = Post.by_nickname_count("user1")
      expect(posts).to eq(1)
    end

    it "get posts which user likes" do
      posts = Post.liked(@user1.id)
      expect(posts).not_to be_empty
    end

    it "get liked postі count by user id" do
      expect(Post.liked_count(@user1.id)).to eq(1)
    end

    it "get posts of followed users by user_id" do
      @user1.follow(@user2)
      posts = Post.followed(@user1.id)
      expect(posts).not_to be_empty
      expect(posts.length).to eq(1)

      create(:post, user: @user2)
      posts = Post.followed(@user1.id)
      expect(posts).not_to be_empty
      expect(posts.length).to eq(2)
    end

    it "posts of followed users will be first" do
      @user1.follow(@user2)
      create(:post, user: @user3, description: "Post by user3")
      create(:post, user: @user2, description: "Post by followed user")

      posts = Post.recent_followed_and_all(@user1.id)
      expect(posts[0].description).to eq("Post by followed user")
      # TODO: exclude duplicated posts for followed users
      # posts[1] - will be the save as post[0] !!!
      expect(posts[2].description).to eq("Post by user3")
    end

    # it "get post count of followed users" do
    #   count_before = Post.followed_count(@user1.id)
    #   create(:post, user: @user2)
    #   count_after = Post.followed_count(@user1.id)
    #   expect(count_after - count_before).to eq(1)
    # end

  end
end
