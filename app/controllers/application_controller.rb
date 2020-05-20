# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :log_after

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name])
  end

  def after_sign_in_path_for(resource)
    view_profile_path(current_user.nickname)
  end

  def log_after
    user_id = current_user.id if user_signed_in?
    nickname = current_user.nickname if user_signed_in?
    Entry.create(user_id: user_id, nickname: nickname, method: request.method, path: request.fullpath, status: response.status, visited_at: DateTime.now)
  end
end
