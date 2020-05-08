require "rails_helper"

RSpec.describe FollowsController, :type => :controller do
  render_views

  include ControllerMacros

  context "user follows user2" do
    let!(:user) { create :user }
    let!(:user2) { create :user }
    let!(:user_login) { login_user user }

    it ".create has status 200" do
      post :create, params: {id: user2.id}, format: :js
      expect(response).to have_http_status(:ok)
    end

    it ".create render template" do
      post :create, params: {id: user2.id}, format: :js
      expect(response).to render_template("create")
    end
  end
end