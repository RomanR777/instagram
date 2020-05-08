require "rails_helper"

RSpec.describe ProfilesController, :type => :controller do

  context "no data" do
    let!(:user) { create :user}
    let!(:params) { { params: { nickname: user.nickname } } }

    it ".view has 200 status" do
      get :view, params
      expect(response).to have_http_status(:ok)
    end

    it ".view renders template" do
      get :view, params
      expect(response).to render_template("view")
    end

    it ".likes has 200 status" do
      get :likes, params
      expect(response).to have_http_status(:ok)
    end

    it ".likes renders template" do
      get :likes, params
      expect(response).to render_template("likes")
    end

    it ".follows has 200 status" do
      get :follows, params
      expect(response).to have_http_status(:ok)
    end

    it ".follows renders template" do
      get :follows, params
      expect(response).to render_template("follows")
    end
  end

  context "with data" do
    let!(:user) { create :user}
    let!(:user2) { create :user}
    let!(:user_posts) { create_list :post, 33, user: user }
    let!(:follow) { user.follow(user2) }
    let!(:user2_posts) { create_list :post, 11, user: user2 }
    let!(:user_liked) { user2_posts[0, 5].each { |post| create(:like, post: post, user: user) } }
    let!(:params) { { params: { nickname: user.nickname } } }

    it ".view assign user posts" do
      get :view, params
      expect(assigns(:posts)).to match_array(user_posts)
    end

    it ".follows assign following users" do
      get :follows, params
      expect(assigns(:follows)).to eq([user2])
    end

    it ".like assign posts" do
      get :likes, params
      expect(assigns(:posts)).to match_array(user2_posts[0, 5])
    end
  end
end
