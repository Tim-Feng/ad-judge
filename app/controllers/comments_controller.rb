class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = User.first

    if @comment.save
      flash[:notice] = "您的留言已送出."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end