class FlagPosController < ApplicationController
  before_action :set_flag_po, only: [:show, :edit, :update, :destroy]

  # GET /flag_pos
  # GET /flag_pos.json
  def index
    @flag_pos = FlagPo.all
  end

  # GET /flag_pos/1
  # GET /flag_pos/1.json
  def show
  end

  # GET /flag_pos/new
  def new
    @flag_po = FlagPo.new
  end

  # GET /flag_pos/1/edit
  def edit
  end

  # POST /flag_pos
  # POST /flag_pos.json
  def create
    @flag_po = FlagPo.new(flag_po_params)

    respond_to do |format|
      if @flag_po.save
        format.html { redirect_to @flag_po, notice: 'Flag po was successfully created.' }
        format.json { render :show, status: :created, location: @flag_po }
      else
        format.html { render :new }
        format.json { render json: @flag_po.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flag_pos/1
  # PATCH/PUT /flag_pos/1.json
  def update
    respond_to do |format|
      if @flag_po.update(flag_po_params)
        format.html { redirect_to @flag_po, notice: 'Flag po was successfully updated.' }
        format.json { render :show, status: :ok, location: @flag_po }
      else
        format.html { render :edit }
        format.json { render json: @flag_po.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flag_pos/1
  # DELETE /flag_pos/1.json
  def destroy
    @flag_po.destroy
    respond_to do |format|
      format.html { redirect_to flag_pos_url, notice: 'Flag po was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flag_po
      @flag_po = FlagPo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flag_po_params
      params.require(:flag_po).permit(:user_id, :post, :reason)
    end
end
