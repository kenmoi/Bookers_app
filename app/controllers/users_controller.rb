class UsersController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @users = @user
    @user_all = User.all
    @book = Book.new
  end
  
  def create
  end
  
  def show
  end
  
  def edit
     @user = User.find(params[:id])
     if current_user == @user
       @user = User.find(params[:id])
     else
       redirect_to user_path(current_user.id)
     end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private
  def user_params
    params.require(:user).permit(:name)
  end

  
end
