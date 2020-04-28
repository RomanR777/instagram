class Post < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :likes
  has_many :comments

  default_scope { order created_at: :desc }

  scope :by_id, -> (user_id) { where('user_id = ?', user_id )}
  scope :by_nickname, -> (nickname) { joins(:user).where(users: {nickname: nickname})}
  scope :liked, -> (user_id) {
      select('posts.*', 'users.*', 'likes.user_id').joins(:user)
      left_outer_joins(:likes).
      where(user_id: user_id)
  }
  scope :followed, -> (user_id) {
    select('posts.*', 'follows.followable_id', 'follows.follower_id').
    joins('left outer join follows on posts.user_id = follows.followable_id').
        where('follows.follower_id = ?', user_id)
  }


  # scope :followed_posts, get_followed_posts
  # def get_followed_posts
  #   Post.
  #       select('posts.*', 'follows.followable_id', 'follows.follower_id').
  #       joins('left outer join follows on posts.user_id = follows.followable_id').
  #       where(created_at: 1.days.ago..Time.now, 'follows.follower_id' => 8)

    # sql2 = Post.select('posts.*', "'empty_column2'", "'empty_column1'").to_sql
  # end




end
