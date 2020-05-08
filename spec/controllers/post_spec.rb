require "rails_helper"

RSpec.describe PostsController, :type => :controller do
  include ControllerMacros

  context "not logged in user can't:" do
    let(:params) { { params: { id: 1 } } }
    let(:redirect_url) { "/users/sign_in" }

    it "#new" do
      get :new
      expect(response).to redirect_to(redirect_url)
    end

    it "#create" do
      post :create
      expect(response).to redirect_to(redirect_url)
    end

    it "#edit" do
      put :edit, params
      expect(response).to redirect_to(redirect_url)
    end

    it "#destroy" do
      delete :destroy, params
      expect(response).to redirect_to(redirect_url)
    end

    it "#like" do
      put :like, params
      expect(response).to redirect_to(redirect_url)
    end
  end

  context "search posts by keyword in user nickname or description" do
    let(:user) { create :user, nickname: "root" }
    let!(:match_in_nickname) { create :post, user: user, description: "some description" }

    let(:user2) { create :user, nickname: "user" }
    let!(:match_in_desc) { create :post, user: user2, description: "The root in desc" }

    let!(:posts) { create_list(:post, 12, user: user2)}

    it "has 200 status on js request" do
      get :search, format: :js, xhr: true
      expect(response).to have_http_status(:ok)
    end

    it "renders template" do
      get :search, params: { q: "root" }, format: :js, xhr: true
      expect(response).to render_template("search")
    end

    it "assigns @posts with searched word" do
      get :search, params: { q: "root" }, format: :js, xhr: true
      post_list = [match_in_nickname, match_in_desc]
      expect(assigns(:posts)).to match_array(post_list)
    end

    it "assigns empty array of posts if no match" do
      get :search, params: { q: "kiwi" }, format: :js, xhr: true
      expect(assigns(:posts)).to eq([])
    end
  end

  context "user like post" do
    let(:user) { create :user }
    let(:user2) { create :user }
    let(:post) { create :post, user: user2}
    let!(:login) { login_user user}
    let(:params) { {id: post.id }  }

    it "has 200 status" do
      put :like, params: params, format: :js, xhr: true
      expect(response).to have_http_status(:ok)
    end

    it "render template" do
      put :like, params: params, format: :js, xhr: true
      expect(response).to render_template("like")
    end

    it "assigns @post" do
      put :like, params: params, format: :js, xhr: true
      expect(assigns(:post)).to eq(post)
    end
  end

end