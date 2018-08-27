class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :follows
  has_many :followings, through: :follows, source: :followed
  has_many :reverse_followings,   foreign_key: "followed_id",
                                  class_name: "Follow",
                                  dependent: :destroy
  has_many :followers, through: :reverse_followings, source: :user
end
