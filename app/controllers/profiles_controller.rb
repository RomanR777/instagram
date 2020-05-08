# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_nickname

  def set_nickname
    @nickname = params[:nickname]
    @user = User.find_by(nickname: @nickname) or raise ActiveRecord::RecordNotFound
  end

  # GET /profiles/:nickname
  def view
    @posts = Post.by_nickname(@nickname)
    paginate(Post.by_nickname(@nickname).count)
  end

  def likes
    user = User.find_by(nickname: @nickname)
    @posts = Post.liked(user.id)
    paginate(Post.liked(user.id).count)
  end

  def follows
    user = User.find_by(nickname: @nickname)
    @follows = user.all_following
    paginate(@follows.count)
  end
end
