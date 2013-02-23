class GuestController < ApplicationController
  
  def index
    @snippets = Snippet.order("id DESC").page(params[:page]).includes(:user, :comments).where(:security => "public")
    @paginate_collection = @snippets
  end
  
  def show
    @snippet = Snippet.find(params[:id])
  end
  
  def tech_videos
    @videos = TodaysSpecial.where(:special_type => "video").order("id DESC").page(params[:page])
    @paginate_collection = @videos    
  end
  
  def tech_news
    @news = TodaysSpecial.where(:special_type => "news").order("id DESC").page(params[:page])
    @paginate_collection = @news       
  end
  
  def tech_articles
    @articles = TodaysSpecial.where(:special_type => "article").order("id DESC").page(params[:page])
    @paginate_collection = @articles      
  end
end
