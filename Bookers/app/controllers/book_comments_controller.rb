class BookCommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		@comment = current_user.book_comments.new(book_comment_params)
		@comment.book_id = book.id
		if @comment.save
			flash[:success] = "Comment was successfully created."
			redirect_back(fallback_location: root_path)
		else
			redirect_back(fallback_location: root_path)
		end
	end
	def destroy
		@comment = BookComment.find(params[:book_id])
		if @comment.user != current_user
			redirect_back(fallback_location: root_path)
		end
		@comment.destroy
		redirect_back(fallback_location: root_path)
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
