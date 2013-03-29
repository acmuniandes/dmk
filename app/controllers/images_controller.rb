class ImagesController < ApplicationController
  # GET /images
  # GET /images.json
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @ad = params[:ad_id]
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new

  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.json
  def create
    @ad = Ad.find(params[:ad_id])
    @image = @ad.images.new

    @image.title = params[:title]

    uploaded_io = params[:dataFile]

    path = Rails.root.join('public', 'uploads', uploaded_io.original_filename);
    File.open(path, 'w:ASCII-8BIT') do |file|
      file.write(uploaded_io.read)

    end
    realPath = File.absolute_path(path).split("public/")[1]
    @image.url= realPath
    if @image.save then
      flash[:notice]="la fuente fue exitosamente creada"
    else
      flash[:error]="error agregando imagen"
    end
    redirect_to @ad
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end
end
