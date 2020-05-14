# frozen_string_literal: true

class LikeStatisticMailer < ApplicationMailer
  default from: ENV.fetch("LIKE_STATISTIC_FROM") { "noreply@instagram.com" }
  layout "mailer"
  def send_like_statistic(email)
    mail(to: email, subject: "Like statistic")
  end
end
