require 'rails_helper'

RSpec.feature "User can: ", type: :feature do
  include FeatureHelper

  describe "authenticate" do
    let!(:user) { build :user }
    let!(:existing_user) {create :user}

    scenario "user sign up" do
      visit("/users/sign_up")

      fill_in("Nickname", :with => user.nickname)
      fill_in("Email", :with => user.email)
      fill_in("Password", :with => user.password)
      fill_in("Password confirmation", :with => user.password)

      click_on("Sign up")

      expect(page).to have_content("Profile")
      expect(page).to have_content(user.nickname)
    end

    scenario "user sign in" do
      visit("/users/sign_in")

      fill_in("user_email", :with => existing_user.email)
      fill_in("user_password", :with => existing_user.password)
      click_on("Log in")

      expect(page).to have_content(existing_user.nickname)
    end

    scenario "user sign out" do
      sign_in(existing_user)
      click_link("Sign Out")
      expect(page).to have_content("Guest")
    end
  end

  describe "login user" do
    let!(:user) { create :user }
    let!(:post) { build :post}

    scenario "create post" do
      sign_in(user)
      visit("/posts/new")

      fill_in("post_description", with: post.description)
      attach_file("post_photo", "./spec/cat.jpeg")
      click_on("Create Post")
      expect(page).to have_content(post.description)
    end
  end
end