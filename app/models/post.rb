# frozen_string_literal: true

class Post < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :likes
  has_many :comments

  validates :description, presence: true

  default_scope { order created_at: :desc }
  scope :by_id, ->(user_id) { where("user_id = ?", user_id) }
  scope :by_nickname, ->(nickname) { joins(:user).where(users: { nickname: nickname }) }
  scope :by_nickname_count, ->(nickname) { by_nickname(nickname).count }
  scope :liked, ->(user_id) { joins(:likes).where(likes: { user_id: user_id }) }
  scope :liked_count, ->(user_id) { liked(user_id).count }

  scope :followed, ->(user_id) {
    select("posts.*",
           "follows.followable_id",
           "follows.follower_id as follower_user_id", # use for sorting in union
           "posts.created_at as follow_created_at"). # use for sorting in union
    joins("left outer join follows on posts.user_id = follows.followable_id").
        where("follows.follower_id = ?", user_id)
  }
  scope :recent_followed_and_all, ->(user_id, limit: 5, offset: 0) {
    followed_sql = recent_followed(user_id).to_sql
    all_other_sql = Post.select("posts.*",
                                "'-1'", # ignore
                                "'-2'", # used for sorting in union
                                "posts.created_at") # used for sorting in union
                                .to_sql
    result_sql = "(#{followed_sql}) UNION (#{all_other_sql})
                   ORDER BY follower_user_id DESC, follow_created_at DESC
                   LIMIT #{limit} OFFSET #{offset}"
    find_by_sql(result_sql)
  }
  scope :followed_count, ->(user_id) { followed(user_id).count("posts.id") }
  scope :recent_followed, ->(user_id) { followed(user_id).where(created_at: 1.days.ago..Time.now) }
  scope :recent_followed_count, ->(user_id) { recent_followed(user_id).count("posts.id") }
  scope :recent_followed_all_count, ->(user_id) { recent_followed_and_all(user_id).count }

  def self.feed(user_id, page: 0, per_page: 5)
    page = page - 1 < 0 ? 0 : page - 1
    offset = page * per_page
    if recent_followed_count(user_id)
      recent_followed_and_all(user_id, limit: per_page, offset: offset)
    else
      Post.all.limit(per_page).offset(offset)
    end
  end

  def self.entries_count(user_id)
    all_count = Post.all.count
    followed_count = user_id.nil? ? 0 : recent_followed_count(user_id)
    all_count + followed_count
  end

  def self.search(keyword)
    Post.joins(:user).where(" posts.description LIKE ? or users.nickname LIKE ? ",
        "%#{keyword}%", "%#{keyword}%")
  end
end
