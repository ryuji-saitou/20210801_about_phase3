class Public::PostsController < ApplicationController
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
      redirect_to root_path
    else
      render :confirm
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    Post.find(params[:id]).update(post_params)
    redirect_to post_path(@post)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to user_path(current_user.id)
  end

  private
  def post_params
    # 複数画像アップ時、PostImageへは配列でデータを渡すこと
    params.require(:post).permit(:action, :time_required, :budget, post_images_images: [])
  end
end
