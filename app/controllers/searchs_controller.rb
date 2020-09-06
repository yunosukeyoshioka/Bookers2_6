class SearchsController < ApplicationController
  def index
  	method = params[:search_method]
    word = params[:search]
    @model = params[:model_method]
 		if @model == 'User'
 			@users = User.search(method,word)
 		elsif @model == 'Book'
 			@books = Book.search(method,word)
 		end	
  end
end

