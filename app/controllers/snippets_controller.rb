class SnippetsController < ApplicationController
  
  before_filter :authenticate_user!#, :except => :create
  # GET /snippets
  # GET /snippets.json
  def index
    case params[:mode]
    when "global"
      @snippets = Snippet.order("id DESC").page(params[:page]).includes(:user, :comments).where(:user_id => current_user.id)
    when "public"
      @snippets = Snippet.order("id DESC").page(params[:page]).includes(:user, :comments).where(:security => "public", :user_id => current_user.id)
    when "private"
      @snippets = Snippet.order("id DESC").page(params[:page]).includes(:user, :comments).where(:security => "private", :user_id => current_user.id)
    else
      @snippets = Snippet.order("id DESC").page(params[:page]).includes(:user, :comments).where(:security => "public")
    end 
    @paginate_collection =  @snippets 
       
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @snippets}
    end
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
    @snippet = Snippet.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @snippet }
    end
  end

  # GET /snippets/new
  # GET /snippets/new.json
  def new
    @snippet = Snippet.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @snippet }
    end
  end

  # GET /snippets/1/edit
  def edit
    @snippet = Snippet.find(params[:id])
  end

  # POST /snippets
  # POST /snippets.json
  def create
    begin
      if params[:absolute_url].blank? &&  params[:code].blank?
        raise "Hey Buddy, Please enter Resource URL or Code Snippet."
      end
      check_resource_url params[:absolute_url]
      Snippet.create!(:technology_id => params[:technology_id],
                      :absolute_url => params[:absolute_url],
                      :description => params[:description],
                      :heading => params[:heading],
                      :security => params[:security],
                      :user_id => current_user.id,
                      :code => params[:code])
      redirect_to snippets_path
    rescue Exception => e
      flash[:error] = e.message
      redirect_to new_snippet_path  
    end
  end

  # PUT /snippets/1
  # PUT /snippets/1.json
  def update_snippet
    @snippet = Snippet.find(params[:id])
      if params[:absolute_url].blank? &&  params[:code].blank?
        raise "Hey Buddy, Please enter Resource URL or Code Snippet."
      end
      check_resource_url params[:absolute_url]
      @snippet.update_attributes!(:technology_id => params[:technology_id],
                                  :absolute_url => params[:absolute_url],
                                  :description => params[:description],
                                  :heading => params[:heading],
                                  :security => params[:security],
                                  :user_id => current_user.id,
                                  :code => params[:code])
      redirect_to snippet_path(@snippet)
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  
  def delete_resource
    @snippet = Snippet.find(params[:id])
    @snippet.destroy
    flash[:info] =  'Resource was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to snippets_url, info: 'Resource was successfully deleted.'}
      format.json { head :no_content }
    end
  end
  
  #Add comment to snippet
  def add_snippet_comment
    @snippet = Snippet.find(params[:id])
    @snippet.comments.create!(:user_id => current_user.id,
                              :message => params[:message])
    redirect_to snippets_path
    flash[:info] = "Successfully added a comment to #{@snippet.heading}."
  end
  
  #Show comment to snippet
  def show_comments
    @snippet = Snippet.find(params[:id])
    @comments= Comment.page(params[:page]).includes(:user).where(:snippet_id => params[:id])
    @paginate_collection =  @comments
  end
  
  
  #Search resource
  def search
    @snippets = Snippet.order("id DESC").page(params[:page]).includes(:user, :comments).where("(heading like ? OR description like ?) AND user_id=?", "%#{params[:query_string]}%", "%#{params[:query_string]}%", current_user.id)
    @paginate_collection =  @snippets
    flash[:error] = "Sorry, We have no results for what you have searched :(" if @snippets.blank?
    render 'index'
  end
  
  #Filter Resources
  def filter
    case params[:mode]
    when "technology"
      if params[:resource_type] == "mine"
        @snippets = Snippet.order("id DESC").page(params[:page]).includes(:user, :comments).where(:technology_id => params[:technology_id], :user_id => current_user.id, :security => "public")
      else    
        @snippets = Snippet.order("id DESC").page(params[:page]).includes(:user, :comments).where(:technology_id => params[:technology_id], :security => "public")                                                                                    
      end                                                                                         
    when "comment"
      if params[:resource_type] == "mine"
        @snippets = Snippet.page(params[:page]).includes(:user, :comments).where(:security => "public", :user_id => current_user.id).order("comments_count DESC")
      else    
        @snippets = Snippet.page(params[:page]).includes(:user, :comments).where(:security => "public").order("comments_count DESC")                                                                                    
      end 
    when "rating"
    else
      @snippets = Snippet.order("id DESC").page(params[:page]).includes(:user, :comments).where(:security => "public")
    end
    @paginate_collection =  @snippets
    render 'index'
  end
  
  
  
  private
  # Here goes the private methods.
  def check_resource_url(url)
    require 'uri'
    raise "Oops :( Invalid resource URL." unless url =~ URI::regexp
  end
end
