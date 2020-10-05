class SessionsController < ApplicationController
  skip_before_action :login_required
  before_action :forbid_login_user, { only: [:new, :create, :login] }
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to top_path, notice: 'ログアウトしました'
  end

  private

  def session_params
    params.required(:session).permit(:email, :password)
  end
end
