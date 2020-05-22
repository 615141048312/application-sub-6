class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "You have created book successfully"
      redirect_to book_path(@new_book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
  	@user = current_user
    @new_book = Book.new
  	@books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    #user.id == @book.user_id
  	@user = User.find_by(id: @book.user_id)
    @new_book = Book.new
    @comment = BookComment.new
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "You have update book successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user_id == current_user.id
  end
end
