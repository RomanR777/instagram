class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, length: {minimum: 4, maximum: 32}, presence: true
  has_one :profile
  after_create :create_profile

  def create_profile
    Profile.create(user: self)
  end

  has_many :posts
  has_one :profile

  has_many :comments

  acts_as_followable
  acts_as_follower

end
