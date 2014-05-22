class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]

  # GET /friendships
  # GET /friendships.json
  def index
    logger.info("-------------->index Friendship session #{session[:login]}");
    if request.format.json?
        friendships_instance =Friendship.new
        @friendships = friendships_instance.getMyfriends(session[:login]); 
    else 
        @friendships=Friendship.where(user_id: session[:login])
    end

  end

  def follower
    logger.info("-------------->follower session #{session[:login]}");
     if request.format.json?
        friendships_instance =Friendship.new
        @friendships = friendships_instance.getMyfriendsMe(session[:login]); 
    end
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
  end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  # GET /friendships/1/edit
  def edit
  end

  # POST /friendships
  # POST /friendships.json
  def create
    if request.format.json?
       @friendship = Friendship.new(friend_id: params[:friend_id])
       @friendship.user_id = session[:login]
       @friendship.save
       render :text => "#{@friendship.id}"
    else
      @friendship = Friendship.new
      friendship = params[:friendship]
      @friendship.friend_id = friendship[:friend_id]
      @friendship.user_id = session[:login]
      if @friendship.save
         redirect_to friendships_url 
      else
        render action: 'new' 
      end
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    logger.info("Delete friend_id 33333")
       logger.info("Delete friend_id #{params[:user_id]}")
         @friendship.destroy
     if request.format.json?
        render text: "Delete"
     else
       @friendship.destroy
      redirect_to friendships_url 
      end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params[:friendship]
    end
end
