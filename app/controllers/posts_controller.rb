class PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @like = Like.new
    @user = User.find(@post.user_id)
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path, notice: "投稿しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @post.update!(post_params)
    redirect_to root_path, notice: "更新しました"
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: "削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:content, :condition, :created_at)
  end

  def ensure_correct_user
    @post = Post.find(params[:id]) # 初期値を入れるため
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end
  end
end
