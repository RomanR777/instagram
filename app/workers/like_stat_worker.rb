# frozen_string_literal: true

class LikeStatWorker
  include Sidekiq::Worker

  def perform(*args)
    User.likes_count_per_user do |user, like_count|
      puts "#{user.nickname}: #{like_count}"
      LikeStatisticMailer.send_like_statistic(user, like_count).deliver_now
    end
  end
end
