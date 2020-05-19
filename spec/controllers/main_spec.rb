# frozen_string_literal: true

require "rails_helper"

RSpec.describe MainController, type: :controller do
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

  describe "#paginate", focus: true do
    context "no posts" do
      it "previous page 0" do
        get :index
        expect(assigns(:previous_page)).to eq(0)
      end

      it "next page 0" do
        get :index
        expect(assigns(:next_page)).to eq(0)
      end

      it "total pages 0" do
        get :index
        expect(assigns(:total_pages)).to eq(0)
      end

      it "offset 0" do
        get :index
        expect(assigns(:offset)).to eq(0)
      end

      it "limit 5 by default" do
        get :index
        expect(assigns(:limit)).to eq(5)
      end

      it "current page 0" do
        get :index
        expect(assigns(:current_page)).to eq(0)
      end
    end

    context "has posts" do
      let!(:user) { create :user }
      let!(:posts) { create_list :post, 13, user: user }

      it "previous page 1" do
        get :index
        expect(assigns(:previous_page)).to eq(1)
      end

      it "next page 2" do
        get :index
        expect(assigns(:next_page)).to eq(2)
      end

      it "total pages 3" do
        get :index
        expect(assigns(:total_pages)).to eq(3)
      end

      it "offset 0" do
        get :index
        expect(assigns(:offset)).to eq(0)
      end

      it "limit 5 by default" do
        get :index
        expect(assigns(:limit)).to eq(5)
      end

      it "current page 1" do
        get :index
        expect(assigns(:current_page)).to eq(1)
      end

      it "navigate to page <= 0" do
        get :index, params: { page: 0 }
        expect(assigns(:current_page)).to eq(1)

        get :index, params: { page: -1 }
        expect(assigns(:current_page)).to eq(1)
        expect(assigns(:offset)).to eq(0)
        expect(assigns(:limit)).to eq(5)
      end

      it "navigate to page > total pages" do
        get :index, params: { page: 4 }
        expect(assigns(:current_page)).to eq(3)
        expect(assigns(:offset)).to eq(10)
        expect(assigns(:limit)).to eq(5)
      end
    end
  end
end
