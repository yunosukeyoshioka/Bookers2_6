class RelationshipsController < ApplicationController

	def follow
		current_user.follow(params[:id])
		redirect_back(fallback_location: books_path)
	end	

	def unfollow
		current_user.unfollow(params[:id])
		redirect_back(fallback_location: books_path)
	end	


	def follower
		@user = User.find(params[:user_id])
	end
		
	def followed
		@user = User.find(params[:user_id])
	end	
	
end
