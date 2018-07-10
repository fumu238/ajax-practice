class BooksController < ApplicationController

  before_action :authenticate_user!


  def index
      # params[:q]['title_or_body_cont_all'] = params[:q]['title_or_body_cont_all'].split(/[\p{blank}\s]+/)
      # binding.pry
      @words = params[:q].delete(:title_or_body_cont) if params[:q].present?
     if @words.present?
      params[:q][:groupings] = []
      @words.split(/[ 　]/).each_with_index do |word, i| #全角空白と半角空白で切って、単語ごとに処理します
      params[:q][:groupings][i] = { title_or_body_cont: word }
       end
     end
      @q = Book.ransack(params[:q])
      @books = @q.result.page(params[:page]).reverse_order
      @book = Book.new
      @all = Book.all
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
