class PostsController < ApplicationController
before_action :ensure_correct_user, only: [:edit , :update , :destroy]


  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
   if @post.save
     redirect_to root_path, notice: "投稿しました"
   else
      flash[:alert]= '回答に不備があります'
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
  end





  private

  def post_params
    params.require(:post).permit(:content,:created_at)
  end

  def ensure_correct_user
    @post = Post.find(params[:id]) #初期値を入れるため
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to  root_path
    end
  end
  

end
