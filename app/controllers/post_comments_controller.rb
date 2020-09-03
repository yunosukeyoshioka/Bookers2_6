class PostCommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		@book_comment = current_user.post_comments.new(post_comment_params)
		@book_comment.book_id = @book.id
		if @book_comment.save
			redirect_back(fallback_location: books_path)
		# else
		# 	@book_comments = PostComment.where(book_id: @book.id)
  #  		render '/books/show'
   	end	
	end
	
	def destroy
		PostComment.find(params[:book_id]).destroy
		redirect_to book_path(current_user)
	end	


	 private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
