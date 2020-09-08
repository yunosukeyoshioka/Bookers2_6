class BooksController < ApplicationController

before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update]
  
  def correct_user
    @book = current_user.books.find_by(id: params[:id])
      unless @book
        redirect_to books_path
      end
  end

  def index
  	@books = Book.all
    @user = current_user
    @book = Book.new
    @book_comments = @book.post_comments
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @post_comment = PostComment.new
    @book_comments = @book.post_comments
    
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
      @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'You have updeted book successfully.'
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render "books/edit"
    end 
  end  

  def create
     @book = Book.new(book_params)
     @book.user_id = current_user.id
      if @book.save
        flash[:notice] = 'You have creatad book successfully.'
        redirect_to book_path(@book)
    else
        @user = current_user
        @books = Book.all
        render "books/index"
     end 
  end		

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to user_path(current_user)
  end 

  private
   def book_params
    params.require(:book).permit(:title, :body)
   end  


end