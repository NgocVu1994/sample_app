class CommentsController < ApplicationController
	before_action :logged_in_user, only: [ :create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@micropost = Micropost.find(params[:comment][:micropost_id])
		@comment = @micropost.comments.build(comment_params)
		respond_to do |format|
      	if !@comment.save
        	flash[:alert] = "You can not comment"
    	 end
     	 format.html { redirect_to @micropost }
     	 format.js { @comments = @micropost.comments }
     	end

    end

	def edit
		@comment = Comment.find(params[:id])
		@micropost = @comment.micropost
		@user = @comment.user
		
	end
	def update
		@comment = Comment.find(params[:id])
		@micropost = @comment.micropost
		if !@comment.update(comment_params)
      	 	flash[:alert] = "Can not edit comment"
    	end
    	redirect_to @micropost
  	end

	def destroy
		@comment.destroy
		flash[:success] = "Comment deleted"
		redirect_to request.referrer 
	end

	private

	def comment_params
		params.require(:comment).permit(:content, :user_id)
	end
	def correct_user
		@comment = current_user.comments.find_by(id: params[:id])
		redirect_to root_url if @comment.nil?
	end
end
