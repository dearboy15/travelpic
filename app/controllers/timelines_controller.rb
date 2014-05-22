class TimelinesController < ApplicationController
  before_action :set_timeline, only: [:show, :edit, :update, :destroy]

  # GET /timelines
  # GET /timelines.json
  def index
    logger.info("-------------->index session #{session[:login]}");
    logger.info("-------------->offset #{params[:offset]}");
    timeline = Timeline.new
    #@timelines = timeline.get_timeline(session[:login])
    @timelines = timeline.get_timeline_with_json(session[:login],params[:offset])
  #  @timelines=@timelines.sort_by{|e| e[:time]}.reverse
  end


    

  # GET /timelines/1
  # GET /timelines/1.json
  def show
  end

  # GET /timelines/new
  def new
    @timeline = Timeline.new
  end

  # GET /timelines/1/edit
  def edit
  end

  # POST /timelines
  # POST /timelines.json
  def create
    logger.info("-------------->timelines session #{session[:login]}");
    @timeline = Timeline.new(timeline_params)
    logger.info("picture_id #{@timeline.picture_id}")
    country = Country.where(country_name: "#{params[:country]}").first

    if country!=nil
        logger.info("not null and id is #{country.id}")
        Picture.find(@timeline.picture_id).update(country_id: "#{country.id}",category_id: "#{params[:type]}")
    else
        country = Country.new(country_name: "#{params[:country]}")
        country.save
        Picture.find(@timeline.picture_id).update(country_id: "#{country.id}",category_id: "#{params[:type]}")
        logger.info("new country id#{country.id}")
    end
    logger.info("cccc #{params[:country]}TTTT")
    logger.info("idid #{params[:type]}")
    #Country.where(country_name: "#{params[:country]}")
    @timeline.user_id =session[:login]
    respond_to do |format|
      if @timeline.save
        format.html { redirect_to @timeline, notice: "#{@timeline.id}" }
        format.json { render status: :created, text: 'created Timeline' }
      else
        format.html { render action: 'new' }
        format.json { render status: :unprocessable_entity, text: 'cannot create Timeline' }
      end
    end
  end

  # PATCH/PUT /timelines/1
  # PATCH/PUT /timelines/1.json
  def update
    respond_to do |format|
      if @timeline.update(timeline_params)
        format.html { redirect_to @timeline, notice: 'Timeline was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @timeline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timelines/1
  # DELETE /timelines/1.json
  def destroy
    @timeline.destroy
    respond_to do |format|
      format.html { redirect_to timelines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timeline
      @timeline = Timeline.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timeline_params
      params.require(:timeline).permit(:text, :time, :picture_id)
    end
end
