class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def show
  	@user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
  	@user = User.find(params[:id])
    if current_user != @user
      redirect_to users_path
    end
  end

  def update
  	@user = User.find(params[:id])
  	 if @user.update(user_params)
      flash[:message] = "プロフィールを編集しました"
  	redirect_to user_path(@user.id)
    else
    render 'users/edit'
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :intro)
  end
end
