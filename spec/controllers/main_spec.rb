require "rails_helper"

RSpec.describe MainController, :type => :controller do
  render_views

  include ControllerMacros

  context "not logged in, no data" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "render index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  context "not logged in and have data" do
    let!(:user) { create :user }
    let!(:posts) { create_list(:post, 23, user: user) }

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "render index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "assigns @posts" do
      get :index
      expect(assigns(:posts)).to eq(posts.reverse![0, 5])
    end
  end

  context "logged in and followed posts appears first" do
    let!(:user) { create :user }
    let!(:login) { login_user user}

    let!(:user2) { create :user }
    let!(:follow) { user.follow(user2) }

    let!(:recent_followed_post) { create :post, user: user2}
    let!(:followed_old_post) { create :post, user: user2, created_at: 2.days.ago }

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "render index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "assigns @posts" do
      get :index
      post_list = [recent_followed_post, recent_followed_post, followed_old_post]
      expect(assigns(:posts)).to eq(post_list)
    end
  end
end