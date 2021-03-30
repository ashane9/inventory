class PurchaseTypesController < ApplicationController
  before_action :set_purchase_type, only: %i[ show edit update destroy ]

  # GET /purchase_types or /purchase_types.json
  def index
    @purchase_types = PurchaseType.all
  end

  # GET /purchase_types/1 or /purchase_types/1.json
  def show
  end

  # GET /purchase_types/new
  def new
    @purchase_type = PurchaseType.new
  end

  # GET /purchase_types/1/edit
  def edit
  end

  # POST /purchase_types or /purchase_types.json
  def create
    @purchase_type = PurchaseType.new(purchase_type_params)

    respond_to do |format|
      if @purchase_type.save
        format.html { redirect_to @purchase_type, notice: "Purchase type was successfully created." }
        format.json { render :show, status: :created, location: @purchase_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @purchase_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_types/1 or /purchase_types/1.json
  def update
    respond_to do |format|
      if @purchase_type.update(purchase_type_params)
        format.html { redirect_to @purchase_type, notice: "Purchase type was successfully updated." }
        format.json { render :show, status: :ok, location: @purchase_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @purchase_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_types/1 or /purchase_types/1.json
  def destroy
    @purchase_type.destroy
    respond_to do |format|
      format.html { redirect_to purchase_types_url, notice: "Purchase type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_type
      @purchase_type = PurchaseType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_type_params
      params.require(:purchase_type).permit(:type_name)
    end
end
