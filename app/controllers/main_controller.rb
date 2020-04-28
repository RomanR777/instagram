class MainController < ApplicationController
  def index
    # byebug
    @posts = Post.all
  end
end
