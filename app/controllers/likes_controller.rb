class LikesController < ApplicationController
  before_action :set_like, only: [:show, :edit, :update,:destroy]


  # GET /likes
  # GET /likes.json
  def index
    #@likes = Like.all
    #@likes = Like.where(picture_id: "#{params[picture_id]}")
    logger.info("picture_id #{params[:picture_id]}");
    like = Like.new
    @likes = like.getUserInfoWhoLikedThisPicture(params[:picture_id]);
    #@likes = Like.where(picture_id: "73")
  end

  # GET /likes/1
  # GET /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(like_params)
    @like.user_id = session[:login] 
    newLike = Like.where(picture_id: "#{@like.picture_id}", user_id: "#{session[:login]}").first
    if newLike ==nil
      respond_to do |format|
        if @like.save
          format.html { redirect_to @like, notice: 'Like was successfully created.' }
          format.json { render text: "#{@like.id}" }
        else
          format.html { render action: 'new' }
          format.json { render json: @like.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
          format.html { render action: 'new' }
          format.json { render text: "Already like #{newLike.id}"}
      end
    end
  end

  # PATCH/PUT /likes/1
  # PATCH/PUT /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: 'Like was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to likes_url }
      format.json { render text: "Unliked" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def like_params
     params.require(:like).permit(:picture_id)
    end
end
