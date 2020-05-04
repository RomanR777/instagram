# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name])
  end

  def paginate(total_entries, per_page: 5, paginator_width: 5)
    # TODO: move all paginator related code to helper module or base controller
    @paginated = false
    @page = params[:page].nil? ? 1 : params[:page].to_i
    @per_page = per_page
    @paginator_width = paginator_width
    @total = total_entries
    @pages_count = @total / @per_page

    if @pages_count == 0
      @start = 0
      @end = 0
      return
    end

    @paginator_width = @paginator_width < @pages_count ? @paginator_width : @pages_count
    @start = @page / @paginator_width * @paginator_width
    @end = @start + @paginator_width
    @paginated = true
    @start, @end = @start + 1, @end + 1 if @start == 0
  end
end
