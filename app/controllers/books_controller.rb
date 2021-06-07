class BooksController < ApplicationController

  def top
  end

  def new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = 'Book was successfully created.'
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render action: :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
    @users = @user
  end

  def show
    @book1 = Book.new
    @book = Book.find(params[:id])
    @users = @book.user
    @post_comment = PostComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if current_user == @book.user
      @book = Book.find(params[:id])
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
