class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    if params[:search]
      @search_term = params[:search]
      @users = @users.search_by(@search_term)
    else
      @users = User.all
    end
  end

  def admins
    @users = User.all
    @admins = User.where("role = admin", params[:role])

    #Client.where("orders_count = ?", params[:orders])
 end

  def blacklist
  	@users = User.all
	@blacklisteds = User.where("blacklisted = yes", params[:role])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @posts = Post.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def countLikes
    @likes = User.likes 
  end
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save #|| @user.attach(params[:avatar])
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params) #|| @user.attach(params[:avatar])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
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
      params.require(:user).permit(:name, :lastname, :email, :picture, :bio, :city, :country, :role, :avatar, :password ,:password_confirmation )
    end 

end
