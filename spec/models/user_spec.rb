require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user1 = create(:user)
  end

  context "validation" do
    it "valid" do
      expect(@user1).to be_valid
    end

    it "has unique nickname" do
      user2 = build(:user, nickname: @user1.nickname)
      expect(user2).to_not be_valid
    end

    it "has unique email" do
      user2 = build(:user, email: 'user1@user1.com')
      expect(user2).to_not be_valid
    end

    it "nickname can't be < 4" do
      user2 = build(:user, nickname: "abc")
      expect(user2).to_not be_valid
    end
  end

  context "profile" do
    it "new profile created for a user" do
      expect(@user1.profile).to_not be_nil
    end
  end
end
