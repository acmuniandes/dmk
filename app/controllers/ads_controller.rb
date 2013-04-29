class AdsController < ApplicationController

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.order('created_at DESC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ads }
    end
  end


  # GET /ads
  # GET /ads.json
  def search
    @categories = Category.get_top(4)
    if params[:query] and params[:query].size > 0 then
      @ads = Ad.search(params[:query])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @results }
    end
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
    @ad = Ad.find(params[:id])
    @is_owner = @ad.user_id == session[:user_id]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ad }
    end
  end

  def home

  end

  # GET /ads/new
  # GET /ads/new.json
  def new
    if session[:user_id]
      @ad = Ad.new
      @categories = Category.all
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
    if session[:user_id]

      @ad = Ad.find(params[:id])
      @topCategories = Category.all
    else
      send_to_fb_login
    end
  end

  # POST /ads
  # POST /ads.json
  def create
    if session[:user_id]
      @ad = Ad.new(params[:ad])
      if !@ad.image || @ad.image==""
        @ad.image = "http://placehold.it/400x400"
      end
      @ad.user_id=session[:user_id]
      @ad.category_id= params[:category]
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
    else
      send_to_fb_login
    end
  end

  # PUT /ads/1
  # PUT /ads/1.json
  def update
    @ad = Ad.find(params[:id])

    if @ad.user_id==session[:user_id]
      respond_to do |format|
        if @ad.update_attributes(params[:ad])
          format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @ad.errors, status: :unprocessable_entity }
        end
      end
    else
      send_to_fb_login
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy

    @ad = Ad.find(params[:id])

    if @ad.user_id == session[:user_id]
      @ad.destroy

      respond_to do |format|
        format.html { redirect_to "/me" }
        format.json { head :no_content }
      end
    else
      send_to_fb_login
    end

  end


  def send_to_fb_login
    flash[:notice] = "Please log-in first"
    redirect_to "/"
  end

  def get_images

    @resp = BingAPI.get_images(params[:query],10)

    respond_to do |format|
      format.json {render json: @resp.body}
    end

  end

  def send_email
    message = params[:message]
    ad = Ad.find(params[:id])
    user_sender = User.find(session[:user_id])
    user_receiver = User.find(ad.user)
    UserMailer.send_email(user_sender, user_receiver,ad,message).deliver
    render text: "mensaje enviado exitosamente"
  end

end
