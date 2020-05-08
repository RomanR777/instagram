require 'rails_helper'

RSpec.feature "Signup", type: :feature do
  # helper methods
  def sign_in(user)
    visit('/users/sign_in')

    fill_in('user_email', :with => user.email)
    fill_in('user_password', :with => user.password)
    click_on('Log in')
  end

  describe "sign up -> sign out -> sign in" do
    let!(:user) { build :user }
    let!(:existing_user) {create :user}

    scenario "user can sign up" do
      visit("/users/sign_up")

      fill_in("Nickname", :with => user.nickname)
      fill_in("Email", :with => user.email)
      fill_in("Password", :with => user.password)
      fill_in("Password confirmation", :with => user.password)

      click_on("Sign up")

      expect(page).to have_content("Profile")
      expect(page).to have_content(user.nickname)
    end

    scenario "user can sign in" do
      visit("/users/sign_in")

      fill_in("user_email", :with => existing_user.email)
      fill_in("user_password", :with => existing_user.password)
      click_on("Log in")

      expect(page).to have_content(existing_user.nickname)
    end

    scenario "user can sign out" do
      sign_in(existing_user)
      click_link("Sign Out")
      expect(page).to have_content("Guest")
    end
  end

  describe "user can create post" do
    let!(:user) { create :user }
    let!(:post) { build :post}

    scenario "user sign_in and create post" do
      sign_in(user)
      visit("/posts/new")

      fill_in("post_description", with: post.description)
      attach_file("post_photo", "./spec/cat.jpeg")
      click_on("Create Post")
      expect(page).to have_content(post.description)
    end
  end

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
