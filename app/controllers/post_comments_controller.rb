class PostCommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		@book_comment = current_user.post_comments.new(post_comment_params)
		@book_comment.book_id = @book.id
		@book_comment.save
		@comments = PostComment.where(book_id:@book.id) 
	end
	
	def destroy
		PostComment.find(params[:id]).destroy
		@book = Book.find(params[:book_id])
		@comments = @book.post_comments
	end	


	private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
