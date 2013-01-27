class SnippetsController < ApplicationController
  # GET /snippets
  # GET /snippets.json
  def index
    if params[:security]
      @snippets = Snippet.where(:security => params[:security]).order('id DESC')
    else
      @snippets = Snippet.all(:order => 'id DESC')
    end

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
      check_resource_url params[:absolute_url]
      Snippet.create!(:technology_id => params[:technology_id],
                      :absolute_url => params[:absolute_url],
                      :description => params[:description],
                      :heading => params[:heading],
                      :security => params[:security])
      redirect_to snippets_path
    rescue Exception => e
      flash[:error] = e.message
      redirect_to new_snippet_path  
    end
  end

  # PUT /snippets/1
  # PUT /snippets/1.json
  def update
    @snippet = Snippet.find(params[:id])

    respond_to do |format|
      if @snippet.update_attributes(params[:snippet])
        format.html { redirect_to @snippet, notice: 'Snippet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
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
  
  private
  # Here goes the private methods.
  def check_resource_url(url)
    require 'uri'
    raise "Oops :( Invalid resource URL." unless url =~ URI::regexp
  end
end
