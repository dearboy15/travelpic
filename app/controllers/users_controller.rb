class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    #@users = User.all
    @users = []
    allusers = User.where("id!=#{session[:login] }")
    allusers.each do |user|
      friendship_status = Friendship.where(user_id: "#{session[:login]}",friend_id: "#{user.id}").first
      if(friendship_status ==nil)
        status =0
        friendship_id=0;
      else 
        status =1
        friendship_id=friendship_status.id
      end
      temp_hash ={id:"#{user.id}",username:"#{user.username}",profileImage:"#{user.profileImage}",status:"#{status}",friendship_id:"#{friendship_id}"} 
     
      @users << temp_hash 
    end
    
  end

  # GET /users/1
  # GET /users/1.json
  def show
    totalPicture=Timeline.where("user_id=#{@user.id}").count
    @user_info ={profileImage:"#{@user.profileImage}", totalPicture:"#{totalPicture}"}
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
       format.html { redirect_to @user, notice: 'User was successfully created.' }
         format.json { render :text => "#{@user.id}"}
      else
        format.html { render action: 'new' }
         format.json { render :text => "-1" }
      end
    end
  end

  # POST /saveProfileImage
  # POST /saveProfileImage.json
  def saveProfileImage
    profileImageData = params[:picture]
     filepath =""
    unless profileImageData.original_filename.blank?
      filename = Digest::SHA1.hexdigest(Time.now.to_i().to_s())
      filename= "profile"+filename+".png"
      logger.info(filename);
      filedir = "public/profile/"
      filepath = File.join(filedir,filename)
  
      f = File.open(filepath, "wb")
      f.write(profileImageData.read)
      f.close
      filepath ="profile/"+filename   
    end
    respond_to do |format|
      if filepath!=""
        format.html { render action: 'new'}
        format.json { render :text => "#{filepath}"}
      else
        format.html { render action: 'new' }
        format.json { render :text => "-1" }
     end
    end
  
  end

   # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password,:profileImage)
    end
end
