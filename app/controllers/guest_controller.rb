class GuestController < ApplicationController
  
  def index
    @snippets = Snippet.order("id DESC").page(params[:page]).includes(:user, :comments).where(:security => "public")
    @paginate_collection = @snippets
  end
  
  def show
    @snippet = Snippet.find(params[:id])
  end
end
