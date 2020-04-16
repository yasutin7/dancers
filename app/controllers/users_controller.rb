class UsersController < ApplicationController
before_action :ensure_correct_user, only: [:edit , :update , :destroy]
before_action :forbid_login_user, {only: [:new,:create]}
skip_before_action :login_required, only: [:new,:create]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).recent
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      flash[:alert] = '入力に不備があります'
      render :new
    end

  end

  def edit
  end

  def update
    if @user.update(users_params)
     redirect_to user_path, notice: "更新しました"
    else 
      flash[:alert] = '入力に不備があります'
      render :new
    end
  end
  
  def destroy
    @user.destroy
  end

  def following
    @title = "フォロー中のユーザー"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end




  private
  
  def users_params
    params.require(:user).permit(:name,:image,:email,:password,:password_confirmation,:genre,:sex,:age,:address, :introduce)
  end

  def ensure_correct_user
    @user = User.find(params[:id])  #初期値を入れるため
    if @current_user.id != params[:id].to_i
      flash[:alert] = "権限がありません"
      redirect_to user_path
    end
  end

end
