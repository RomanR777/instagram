# frozen_string_literal: true

class LikeStatisticMailer < ApplicationMailer
  default from: ENV.fetch("LIKE_STATISTIC_FROM") { "noreply@instagram.com" }
  layout "mailer"
  def send_like_statistic(user, like_count)
    @user, @like_count = user, like_count
    mail(to: user.email, subject: "Like statistic") if like_count > 0
  end
end
