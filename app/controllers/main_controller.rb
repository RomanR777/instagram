# frozen_string_literal: true

class MainController < ApplicationController
  def paginate(total_entries, per_page: 5)
    @total_pages = 0
    @current_page = 0
    @previous_page = 0
    @next_page = 0
    offset = 0
    limit = per_page
    return offset, limit if total_entries.nil? || total_entries <= 0 || total_entries <= limit

    @total_pages = total_entries % per_page > 0 ? (total_entries / per_page) + 1 : total_entries / per_page

    if params[:page].nil? || params[:page].to_i <= 0
      @current_page = 1
    elsif params[:page].to_i > @total_pages
      @current_page = @total_pages
    else
      @current_page = params[:page].to_i
    end

    @previous_page = @current_page - 1 <= 0 ? 1 : @current_page - 1
    @next_page = @current_page + 1 > @total_pages ? @total_pages : @current_page + 1

    return (@current_page - 1) * limit, limit
  end

  def index
    user_id = current_user ? current_user.id : nil
    @offset, @limit = paginate(Post.entries_count(user_id))
    @posts = Post.feed(user_id, offset: @offset, limit: @limit)
  end
end
