class Book < ApplicationRecord
	belongs_to :user
	validates :title, presence: true
	validates :body, presence: true, length: { maximum: 200 }
	#投稿
	has_many :post_comments, dependent: :destroy
	#いいね
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end	

 	def self.search(method,search)
    if method == "forward_match"
    	Book.where("title LIKE ?", "#{search}%")
    elsif method == "backward_match"
    	Book.where("title LIKE ?", "%#{search}")	
    elsif method == "parfect_match"
    	Book.where(title: search)
    elsif method == "partial_match"	
     	Book.where("title LIKE ?", "%#{search}%")	
		end
	end
		
end
