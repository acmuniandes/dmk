require 'net/https'
require 'uri'

class AdsController < ApplicationController
  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ads }
    end
  end

  def images

  end

  # GET /ads
  # GET /ads.json
  def search
    if params[:query] and params[:query].size  > 0 then
      @ads = Ad.search(params[:query])
    end
    @topCategories = Category.get_top(20)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @results }
    end
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
    @ad = Ad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ad }
    end
  end

  # GET /ads/new
  # GET /ads/new.json
  def new
    if session[:user_id] then
      @ad = Ad.new
      @topCategories = Category.as_list
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @ad }
      end
    else
      send_to_fb_login
    end
  end

  # GET /ads/1/edit
  def edit
    @ad = Ad.find(params[:id])
    @topCategories = Category.all
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(params[:ad])
    @ad.user_id=session[:user_id]
    @ad.category_id= Category.get_id(params[:category])
    respond_to do |format|
      if @ad.save
        flash[:success]="Anuncio exitosamente creado"
        format.html { redirect_to @ad }
        format.json { render json: @ad, status: :created, location: @ad }
      else
        format.html { render action: "new" }
        format.json { render json: @ad.errors, status: :unprocessable_entity }


      end
    end
  end

  # PUT /ads/1
  # PUT /ads/1.json
  def update
    @ad = Ad.find(params[:id])

    respond_to do |format|
      if @ad.update_attributes(params[:ad])
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy

    respond_to do |format|
      format.html { redirect_to ads_url }
      format.json { head :no_content }
    end
  end


  def send_to_fb_login
    redirect_to "/auth/facebook"
  end

  def get_images




    query=params[:query]
    query=URI.escape(query)
    limit=10
    u = '5MoQWsdQ6EbW78VA8YhsS1snfI6YIvbOMTzoVT+GXqs='
    url="api.datamarket.azure.com"
    puts "opening #{url}"
    http = Net::HTTP.new(url,443)

    http.use_ssl = true



    http.start do |http|

      req = Net::HTTP::Get.new("/Data.ashx/Bing/Search/v1/Image?Query=%27#{query}%27&$top=10&$format=JSON")

      # we make an HTTP basic auth by passing the
      # username and password
      puts "request req"
      req.basic_auth u, u

      @resp = http.request(req)

    end

    respond_to do |format|
      format.json {render json: @resp.body}
    end

  end

  def send_email
    message = params[:message]
    ad = Ad.find(params[:id])
    user_sender = User.find(session[:user_id])
    user_receiver = User.find(ad.user)
    UserMailer.send_email(user_sender, user_receiver,ad,message).deliver;
    render text: "mensaje enviado exitosamente"
  end

end
