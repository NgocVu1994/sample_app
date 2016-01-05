class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

   def show
    @micropost = Micropost.find(params[:id])
    @comment = @micropost.comments.build 
    @comments = @micropost.comments.paginate(page: params[:page])
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Entry created!"
      redirect_to root_url|| current_user
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  def edit
    @micropost = Micropost.find(params[:id])
   
  end
  def update
     @micropost = Micropost.find(params[:id])
     if @micropost.update(micropost_params)
      flash[:success] = "Entry updated"
    else
      flash[:alert] = "Can not update Entry"
    end
    redirect_to root_url
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Entry deleted"
    redirect_to request.referrer || root_url

  end

  private

    def micropost_params
      params.require(:micropost).permit(:content,:title, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end