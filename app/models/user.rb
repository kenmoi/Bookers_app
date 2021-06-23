class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "follower_id"
  has_many :followers, through: :follower_relationships, source: :followed
  has_many :followed_Relationships, class_name: "Relationship", foreign_key: "followed_id"
  has_many :followeds, through: :followed_Relationships, source: :follower

  
  def following?(other_user)
    self.followers.include?(other_user)
  end

  # ユーザーをフォローする
  def follow(other_user)
    unless self == other_user
    self.follower_relationships.create(followed_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    self.follower_relationships.find_by(followed_id: other_user.id).destroy
  end

         
end
