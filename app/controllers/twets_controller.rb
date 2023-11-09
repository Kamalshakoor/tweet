class TwetsController < ApplicationController
  before_action :set_twet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index,:show]
  before_action :set_twet, only: [:show, :like]


  # GET /twets or /twets.json
  def index
    @twets = Twet.all.order('created_at DESC')
    @twet = Twet.new
  end
  
  def like
    # Check if the user has already liked this Twet
    if @twet.likes.exists?(user_id: current_user.id)
      flash[:alert] = "You've already liked this Twet."
    else
      # Create a new like only if the user hasn't liked it before
      @twet.likes.create(user_id: current_user.id)
      @twet.increment_likes_count
      flash[:notice] = "You've liked this Twet."
    end

    redirect_to root_path
  end

  # GET /twets/1 or /twets/1.json
  def show
    redirect_to root_path
  end

  # GET /twets/new
  def new
    @twet = current_user.twets.build
  end

  # GET /twets/1/edit
  def edit
  end

  # POST /twets or /twets.json
  def create
    @twet = current_user.twets.build(twet_params)

    respond_to do |format|
      if @twet.save
        format.html { redirect_to twet_url(@twet), notice: "Twet was successfully created." }
        format.json { render :show, status: :created, location: @twet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @twet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /twets/1 or /twets/1.json
  def update
    respond_to do |format|
      if @twet.update(twet_params)
        format.html { redirect_to twet_url(@twet), notice: "Twet was successfully updated." }
        format.json { render :show, status: :ok, location: @twet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @twet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twets/1 or /twets/1.json
  def destroy
    @twet.destroy

    respond_to do |format|
      format.html { redirect_to twets_url, notice: "Twet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twet
      @twet = Twet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def twet_params
      params.require(:twet).permit(:twet,:user_id)
    end
end
