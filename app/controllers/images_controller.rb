class ImagesController < ApplicationController
  
  before_filter :require_user
  
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
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = Image.new
    # @image = @imageable unless @imageable.nil?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  def edit
    @image = Image.find(params[:id])
  end
  
  def create
    @imageable = find_imageable(params[:image])
    @image = @imageable.images.build(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to @imageable, notice: 'Image was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to action: "index" }
        # format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        # format.json { head :no_content }
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
  
  private
    def find_imageable(image_hash)
      return image_hash[:imageable_type].constantize.find(image_hash[:imageable_id])
    end
end
