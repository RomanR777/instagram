# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :destroy, :new,
                                            :like, :dislike]
  before_action :set_post, only: [:show, :edit, :update,
                                  :destroy, :followee]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)
    @post.photo.attach(post_params[:photo])
    respond_to do |format|
      if @post.save
        format.html { redirect_to profiles_path, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
        ActionCable.server.broadcast "feed_channel",
                                     content: get_channel_message

      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_channel_message
    { 'user_id': current_user.id, 'post_id': @post.id }
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to profiles_path, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to profiles_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # PUT /post/1/like
  def like
    @post = Post.find(params[:id])
    @post.likes.find_or_create_by(user_id: current_user.id)
    respond_to do |format|
      format.js
    end
  end

  # DELETE /posts/1/dislike
  def dislike
    post = Post.find(params[:id])
    current_like = post.likes.find_by(user_id: current_ser.id)
    current_like.delete if current_like
    respond_to do |format|
      format.js
    end
  end

  # get /posts/search?q=...
  def search
    @posts = Post.search(params[:q])
    respond_to do |format|
      format.js
    end
  end

  # get /posts/:id/followee
  def followee
    post = Post.find(params[:id])
    return @post = nil if current_user.nil?
    @post = current_user.follow(post.user) ? post : nil
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:description, :photo)
    end
end
