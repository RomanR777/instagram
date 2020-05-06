# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, length: { minimum: 4, maximum: 32 },
            presence: true, uniqueness: true
  validates :email, uniqueness: true

  after_create :create_profile
  def create_profile
    Profile.create(user: self)
  end

  has_many :likes
  has_many :posts
  has_many :comments
  has_one :profile

  acts_as_followable
  acts_as_follower

  def likes?(post)
    !self.likes.find_by(post: post).nil?
  end
end
