class FlagPostsController < ApplicationController
  before_action :set_flag_post, only: [:show, :edit, :update, :destroy]

  # GET /flag_posts
  # GET /flag_posts.json
  def index
    @flag_posts = FlagPost.all
  end

  # GET /flag_posts/1
  # GET /flag_posts/1.json
  def show
  end

  # GET /flag_posts/new
  def new
        @flag_post = FlagPost.new(post_id: params[:post_id])
  end

  # GET /flag_posts/1/edit
  def edit
  end

  # POST /flag_posts
  # POST /flag_posts.json
  def create
    @flag_post = FlagPost.new(flag_post_params)
    @flag_post.user_id = current_user.id

    respond_to do |format|
      if @flag_post.save
        format.html { redirect_to '/posts', notice: 'Post was successfully reported' }
        format.json { render :show, status: :created, location: @flag_post }
      else
        format.html { render :new }
        format.json { render json: @flag_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flag_posts/1
  # PATCH/PUT /flag_posts/1.json
  def update
    respond_to do |format|
      if @flag_post.update(flag_post_params)
        format.html { redirect_to @flag_post, notice: 'Flag post was successfully updated.' }
        format.json { render :show, status: :ok, location: @flag_post }
      else
        format.html { render :edit }
        format.json { render json: @flag_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flag_posts/1
  # DELETE /flag_posts/1.json
  def destroy
    @flag_post.destroy
    respond_to do |format|
      format.html { redirect_to flag_posts_url, notice: 'Flag post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flag_post
      @flag_post = FlagPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flag_post_params
      params.require(:flag_post).permit(:post_id, :user_id, :reason)
    end
end
