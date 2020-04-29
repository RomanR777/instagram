class MainController < ApplicationController
  def index
    # TODO: move all paginator related code to helper module or base controller
    # @page = params[:page].nil? ? 1 : params[:page].to_i
    # @per_page = 5
    # @paginator_width = 5
    # @total = Post.entries_count(user_id)
    # @pages_count = @total / @per_page
    # @paginator_width = @paginator_width < @pages_count ? @paginator_width : @pages_count
    # @start = @page / @paginator_width * @paginator_width
    # @end = @start + @paginator_width
    # @start, @end = @start + 1, @end + 1 if @start == 0

    user_id = current_user ? current_user.id : nil
    paginate(Post.entries_count(user_id))
    @posts = Post.feed(user_id, page: @page, per_page: @per_page)
  end
end
