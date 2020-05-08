require 'rails_helper'

RSpec.feature "Logged in user can: like post, follow user", type: :feature do
  include FeatureHelper

  describe "user can follow another user, user can like post of another user", js: true do
    let!(:user1) { create :user }
    let!(:user2) { create :user }

    let!(:user2_post) do
      post = create :post, user: user2
      post.photo.attach(io: File.open("./spec/cat.jpeg"), filename: "cat.jpeg")
      post
    end

    scenario "user logged in and click on button like of a post" do
      sign_in(user1)
      visit("/")
      expect(page).to have_content(user2.nickname)
      click_on("post-like-#{user2_post.id}")
      visit("/profiles/#{user1.nickname}/likes")
      expect(page).to have_content(user2_post.description)
    end

    scenario "user logged in and click on follow button under post" do
      sign_in(user1)
      visit("/")
      expect(page).to have_content(user2.nickname)
      click_on("user-post-follow-#{user2_post.user.id}#{user2_post.id}")
      visit("/profiles/#{user1.nickname}/follows")
      expect(page).to have_content(user2.nickname)
    end
  end
end