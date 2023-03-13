class UsersController < ApplicationController

def create
  @user = User.new(user_params)
  if @user.save
    redirect_to root_path, success: 'successfully'
  else
    flash.new[:denger] = "failse"
    render :new
  end
end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
     @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice]="successfully"
    redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
