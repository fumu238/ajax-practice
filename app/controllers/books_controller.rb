class BooksController < ApplicationController

  before_action :authenticate_user!


  def index
      @books = Book.all
      @book = Book.new
  end

  def show
      @bookl = Book.find(params[:id])
      @book = Book.new
  end

  def edit
      @book = Book.find(params[:id])
      if @book.user_id != current_user.id
        redirect_to books_path
      end

  end

  def update
       @book = Book.find(params[:id])
       if @book.update(book_params)
        flash[:message] = "投稿を編集しました"
       redirect_to book_path(@book)
     else
       render 'books/edit'
     end
  end

  def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
    if @book.save
      flash[:message] = "投稿を作成しました"
      redirect_to book_path(@book)
    else
      @books = Book.all
      render 'books/index'
    end
  end


  def destroy
      book = Book.find(params[:id])
     if book.destroy
      flash[:message] = "投稿を削除しました"
      redirect_to books_path
    end
  end

  private
      def book_params
        params.require(:book).permit(:title, :body)
      end

end
