
class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all.order("id desc").limit(15).offset(0)
  end

# POST /pictures.json
  def getPictureByCountry
     countryID = params[:id]
     if countryID == "-1"
      @pictures=[]
      timelines = Timeline.where(user_id: "#{session[:login]}").order("id desc")
      timelines.each do |timeline|
         picture = Picture.where(id:"#{timeline.picture_id}").first
        @pictures << picture
      end
     else
      @pictures = Picture.where(country_id: "#{params[:id]}").order("id desc").limit(12)
     end
    
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show

  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json

  def create
      # if request.format.json?
    #@userfile = params[:picture][:picture_url]

   
    @userfile = params[:picture]
    path = save_file( @userfile)
    #logger.info("pic file #{@userfile}");
    logger.info("-------------->Picture session #{session[:login]}");
    @picture = Picture.new(picture_url: path)
      
    respond_to do |format|
      if @picture.save
        format.html { render action: 'new'}
        format.json { render :text => "#{@picture.id}"}
      else
          format.html { render action: 'new' }
          format.json { render :text => "-1" }
      end
    end
   # else
   #   @picture = Picture.new(picture_params)
   #   respond_to do |format|
   #     if @picture.save
   #       format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
   #       format.json { render action: 'show', status: :created, location: @picture }
   #     else
   #       format.html { render action: 'new' }
   #       format.json { render json: @picture.errors, status: :unprocessable_entity }
   #     end
   #   end
   # end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:picture_url)
    end

     def save_file(upload)
    unless upload.original_filename.blank?
      filename = Digest::SHA1.hexdigest(Time.now.to_i().to_s())
     filename= filename+".png"
     # while UploadFile.exists?(:filename_new => "files/#{filename}")
     #   filename = Digest::SHA1.hexdigest(Time.now.to_i().to_s())
     # end
     logger.info(filename);
      filedir = "public/files/"
      filepath = File.join(filedir,filename)
  
      f = File.open(filepath, "wb")
      f.write(upload.read)
      f.close
      filepath ="files/"+filename
  
      return filepath
    end
  end
  
end
