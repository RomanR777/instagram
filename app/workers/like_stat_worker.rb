# frozen_string_literal: true

class LikeStatWorker
  include Sidekiq::Worker

  def perform(*args)
    LikeStatisticMailer.send_like_statistic("test@test.com").deliver_now
  end
end
