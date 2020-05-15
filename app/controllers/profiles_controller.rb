# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_nickname

  def set_nickname
    @nickname = params[:nickname]
    @user = User.find_by(nickname: @nickname) or raise ActiveRecord::RecordNotFound
  end

  # GET /profiles/:nickname
  def view
    @posts = Post.by_nickname(@nickname).page params[:page]
  end

  # GET /profiles/:nickname/likes
  def likes
    user = User.find_by(nickname: @nickname)
    @posts = Post.liked(user.id).page params[:page]
    render "view"
  end

  # GET /profiles/:nickname/follows
  def follows
    user = User.find_by(nickname: @nickname)
    @follows = user.all_following
  end
end
