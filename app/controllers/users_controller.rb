class UsersController < ApplicationController

  def new
    if user_signed_in?
      @user = User.find(params[:id])
    else
      flash[:notice] = 'こちらからご登録後に閲覧いただけます！'
      redirect_to new_user_registration_path
    end
  end

  def index
    @user = User.find(current_user.id)
    @users = @user
    @user_all = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @users = @user
    @books = @user.books
    @book = Book.new
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
    @user = User.find(params[:id])
    @user.save!
    render action: 'new'
    nil
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end

end
