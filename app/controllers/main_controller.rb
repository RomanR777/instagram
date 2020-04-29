class MainController < ApplicationController
  def index
    user_id = current_user ? current_user.id : nil
    paginate(Post.entries_count(user_id))
    @posts = Post.feed(user_id, page: @page, per_page: @per_page)
  end
end
