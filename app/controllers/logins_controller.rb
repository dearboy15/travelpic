class LoginsController < ApplicationController
  #before_action :set_login, only: [:show, :edit, :update, :destroy]
  def new
    @user = User.new
  end

  # POST /logins
  def create
    if params[:user]
      @user=User.new(user_params)
    else
      @user = User.new(username: params[:username], password: params[:password])
    end 
    respond_to do |format|
      if @user.registered?
        logger.info("registered!! UserID#{@user.id}")
        session[:login] = @user.id
        format.html { redirect_to timelines_path, text: "Login Succeeded!"}
        format.json { render :text => "#{@user.id}" }
      else
        logger.info("Not yet registered")
        format.html { render action: 'new'}
        format.json { render :text => "-1"}
      end
    end
  end

  def destroy
    session[:login] = nil
    #render :text => "delete session"
    respond_to do |format|
        format.html { redirect_to new_login_path}
        format.json { render :text => "delete session" }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username,:password)
    end
end
