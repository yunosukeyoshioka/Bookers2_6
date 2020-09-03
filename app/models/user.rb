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
         #投稿
         has_many :post_comments, dependent: :destroy

  #sing up入力画面でIntroduction can't be blankのエラーが
  validates :name, presence: true, length: { in: 2..20 }  
  validates :introduction, length: { maximum: 50 } 
end
