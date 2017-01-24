class LinksController < ApplicationController
  def index
    @hot_links = Link.hot
    @links = current_user.links.all
  end
  
  def edit
    @link = Link.find(params[:id])
  end
  
  def update 
    @link = Link.find(params[:id])
    if @link.update(link_params)
      redirect_to links_path
    else
      flash[:error] = @link.errors.full_messages.join(' ')
      redirect_to edit_link_path
    end
  end
  
  private
  
  def link_params
    params.require(:link).permit(:title, :url)
  end
end
