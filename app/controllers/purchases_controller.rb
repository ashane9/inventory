class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[ show edit update destroy ]
  helper_method :add_purchase_id

  # GET /purchases or /purchases.json
  def index
    clear_redirect
    @purchases = Purchase.all
  end

  def return_value_of_symbol(obj,sym)
    obj.object.send(sym)
    # number_to_currency(form.object.sale_price)
  end

  # GET /purchases/1 or /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
    redirect_setup
  end

  # GET /purchases/1/edit
  def edit
  end

  def add_purchase_id(purchase_id)
    @from_id = Rails.cache.read("from_id")
    Rails.cache.delete("from_id")
    if @from_id != ''
      if @redirect_path.include? 'item'
        Item.where(id: @from_id).update({purchase_id: purchase_id})
      elsif @redirect_path.include? 'autograph'
        Autograph.where(id: @from_id).update({purchase_id: purchase_id})
      end
    end
  end

  # POST /purchases or /purchases.json
  def create    
    @redirect_path = Rails.cache.read("redirect_path")
    puts @redirect_path
    if params[:type_name] != ''
      @purchase_type = PurchaseType.new(purchase_type_params)
      @purchase_type.save
      @purchase_type_id = PurchaseType.where(type_name: @purchase_type.type_name).first.id
    else
      @purchase_type_id = params[:purchase][:purchase_type_id]
    end
    
    @purchase = Purchase.new(purchase_params.merge!({purchase_type_id: @purchase_type_id}))
    
    respond_to do |format|
      if @purchase.save
        
        add_purchase_id(@purchase.id)
        unless @redirect_path.nil? or @redirect_path.eql? 'new_purchase_path'
          if @from_id.nil?
            format.html { redirect_to send @redirect_path, notice: "Purchase was successfully created." }
          else
            format.html { redirect_to send @redirect_path, @from_id, notice: "Purchase was successfully created." }
          end
          Rails.cache.delete("redirect_path")
          puts "redirect_path is deleted in purchases"
        else
          format.html { redirect_to @purchase, notice: "Purchase was successfully created." }
          format.json { render :show, status: :created, location: @purchase }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1 or /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: "Purchase was successfully updated." }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1 or /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: "Purchase was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_params
      params.require(:purchase).permit(:invoice_number, :purchase_type, :location, :date, :source, :sale_price, :buyer_premium, :shipping, :total_cost)
    end
    def purchase_type_params
      params.permit(:type_name)
    end
end
