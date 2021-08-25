class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @post.post_images.build
  end

  # def confirm
  #   @post = Post.new(post_params)
  # end

  # def back
  #   @post = Post.new(post_params)
  #   render :new
  # end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_path, notice: "投稿が完了しました"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if Post.find(params[:id]).update(post_params)
      redirect_to post_path(@post), notice: "投稿内容を更新しました"
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to user_path(current_user.id), alert: "投稿を削除しました"
  end

  private
  def post_params
    # 複数画像アップ時、PostImageへは配列でデータを渡すこと
    params.require(:post).permit(:action, :time_required, :budget, post_images_images: [])

  def correct_user
    @post = Post.find(params[:id])
    redirect_to root_path unless @post.user == current_user
  end

  end
end
