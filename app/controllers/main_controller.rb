class MainController < ApplicationController
  def index
    user_id = current_user ? current_user.id : nil
    @posts = Post.feed(user_id)
  end
end
