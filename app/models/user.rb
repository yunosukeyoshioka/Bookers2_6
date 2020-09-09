class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         #本
         has_many :books, dependent: :destroy
         attachment :profile_image
         #いいね
         has_many :favorites, dependent: :destroy
         #コメント
         has_many :post_comments, dependent: :destroy
         #フォロー取得
         has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
         #フォロワー取得
         has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
         #自分がフォローしている人を取得
         has_many :following_user, through: :follower, source: :followed
         #自分をフォローしている人を取得
         has_many :follower_user, through: :followed, source: :follower

  #ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end  
  #ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end  
  #フォローしているかどうかの確認。フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end 

  #検索機能
  def self.search(method,search)
    if method == "forward_match"
      User.where("name LIKE ?", "#{search}%")
    elsif method == "backward_match"
      User.where("name LIKE ?", "%#{search}") 
    elsif method == "parfect_match"
      User.where(name: search)
    elsif method == "partial_match" 
      User.where("name LIKE ?", "%#{search}%")  
    end
  end

  #sing up入力画面でIntroduction can't be blankのエラーが
  validates :name, presence: true, length: { in: 2..20 }  
  validates :introduction, presence: true, length: { maximum: 50 } 
end
