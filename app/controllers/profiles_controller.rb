class ProfilesController < ApplicationController
  before_action :set_nickname

  def set_nickname
    @nickname = params.key?(:nickname) ? params[:nickname] : current_user.nickname
  end

  # GET /profiles
  def index
    paginate(Post.by_nickname_count(@nickname))
    @posts = Post.by_nickname(@nickname)
  end

  # GET /profiles/:nickname
  def view
    paginate(Post.by_nickname_count(@nickname))
    @posts = Post.by_nickname(@nickname)
  end

  def likes
    user = User.find_by(nickname: @nickname)
    paginate(Post.liked_count(@nickname))
    @posts = Post.liked(user.id)
  end

  def follows
    user = User.find_by(nickname: @nickname)
    @follows = user.all_following
    paginate(@follows.count)
  end
end