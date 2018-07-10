class LikesController < ApplicationController


  def create
     @book = Book.find(params[:book_id])
     @like = Like.create(user_id: current_user.id, book_id: params[:book_id])
     respond_to do |format|
      format.js
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    like = Like.find_by(user_id: current_user.id, book_id: params[:book_id]).destroy
    respond_to do |format|
      format.js
    end
  end

end
