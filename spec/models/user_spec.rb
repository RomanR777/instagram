require "rails_helper"

RSpec.describe User, type: :model do
  context "validation" do
    let!(:user1) { create :user }

    it "valid" do
      expect(user1).to be_valid
    end

    it "has unique nickname" do
      user2 = build(:user, nickname: user1.nickname)
      expect(user2).to_not be_valid
    end

    it "has unique email" do
      user2 = build(:user, email: user1.email)
      expect(user2).to_not be_valid
    end

    it "nickname can't be < 4" do
      user2 = build(:user, nickname: "abc")
      expect(user2).to_not be_valid
    end
  end

  context "profile" do
    it "new profile created for a user" do
      user = create :user
      expect(user.profile).to_not be_nil
    end
  end

  context "user has liked posts" do
    let!(:user3) { create :user }
    let!(:user4) { create :user }
    let!(:user3_posts) { create_list :post, 6, user: user3 }
    let!(:user4_posts) { create_list :post, 3, user: user4 }

    let!(:user3_likes) { user3_posts.map { |post| create :like, post: post, user: user4 } }
    let!(:user4_likes) { user4_posts[0, 2].map { |post| create :like, post: post, user: user3 } }

    it "count user likes" do
      user3.get_user_likes_count do |user, count|
        if user == user3
          expect(count).to eq(6)
        end
        if user == user4
          expect(count).to eq(2)
        end
      end
    end
  end
end
