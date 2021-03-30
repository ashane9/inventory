class AutographsController < ApplicationController
  before_action :set_autograph, only: %i[ show edit update destroy ]

  # GET /autographs or /autographs.json
  def index
    @autographs = Autograph.all
  end

  # GET /autographs/1 or /autographs/1.json
  def show
    # unless params[:from].nil?
      redirect_setup
      # from_id = params[:from_id]
      # redirect_path = "#{params[:from]}_path" 
      # Rails.cache.write("redirect_path", redirect_path)
      # Rails.cache.write("from_id", from_id)
    # end
  end

  # GET /autographs/new
  def new
    @autograph = Autograph.new
    redirect_setup
    # unless params[:from].nil?
    #   from_id = params[:from_id]
    #   redirect_path = "#{params[:from]}" 
    #   Rails.cache.write("redirect_path", redirect_path)
    #   Rails.cache.write("from_id", from_id)
    # end
  end

  # GET /autographs/1/edit
  def edit
  end

  # POST /autographs or /autographs.json
  def create
    @autograph = Autograph.new(autograph_params)

    respond_to do |format|
      if @autograph.save
        # format.html { redirect_to @autograph, notice: "Autograph was successfully created." }
        # format.json { render :show, status: :created, location: @autograph }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @autograph.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /autographs/1 or /autographs/1.json
  def update
    respond_to do |format|
      if @autograph.update(autograph_params)
        format.html { redirect_to @autograph, notice: "Autograph was successfully updated." }
        format.json { render :show, status: :ok, location: @autograph }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @autograph.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /autographs/1 or /autographs/1.json
  def destroy
    @autograph.destroy
    respond_to do |format|
      format.html { redirect_to autographs_url, notice: "Autograph was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_autograph
      @autograph = Autograph.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def autograph_params
      params.require(:autograph).permit(:name, :authentication, :authentication_number)
    end
end
