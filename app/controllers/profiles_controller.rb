class ProfilesController < ApplicationController
  before_action :set_nickname

  def set_nickname
    @nickname = params.key?(:nickname) ? params[:nickname] : current_user.nickname
  end

  # GET /profiles
  def index
    @posts = Post.by_nickname(current_user.nickname)
  end

  # GET /profiles/:nickname
  def view
    nickname = params[:nickname]
    @posts = Post.by_nickname(nickname)
  end

  def likes
    user = User.find_by(nickname: @nickname)
    @posts = Post.liked(user.id)
  end

  def follows
    nickname = params[:nickname]
    user = User.find_by(nickname: nickname)
    @posts = Post.followed(user.id)
  end
end