class PurchasesController < ApplicationController
  include Secured
  before_action :set_purchase, only: %i[ edit update destroy ]
  helper_method :add_purchase_id, :get_purchase_name, :get_purchase_description, :get_autograph_info, :get_item_info, :total_sale_price

  # GET /purchases or /purchases.json
  def index
    clear_redirect
    @purchases = Purchase.where(owned_by: user).all
  end

  def total_sale_price
    purchase_params[:sale_price].gsub(/[^\d\.]/, '').to_f + 
    purchase_params[:buyer_premium].gsub(/[^\d\.]/, '').to_f + 
    purchase_params[:shipping].gsub(/[^\d\.]/, '').to_f + 
    purchase_params[:additional].gsub(/[^\d\.]/, '').to_f - 
    purchase_params[:discount].gsub(/[^\d\.]/, '').to_f
  end

  def return_value_of_symbol(obj,sym)
    obj.object.send(sym)
    # number_to_currency(form.object.sale_price)
  end

  def get_item_info    
    Item.where(id: params[:from_id]).first
  end

  def get_autograph_info
    Autograph.where(id: params[:from_id]).first
  end

  def get_purchase_name(purchase)
    if purchase.id.nil?
      item = get_item_info if params[:from].include? 'item'
      autograph = get_autograph_info if params[:from].include? 'autograph'
    else
      item = Item.where(purchase_id: purchase.id).first
      autograph = Autograph.where(purchase_id: purchase.id).first
    end

    if item
      item.item_name
    elsif autograph
      autograph.name
    end
  end

  def get_purchase_description(purchase)
    if purchase.id.nil?
      item = get_item_info if params[:from].include? 'item'
      autograph = get_autograph_info if params[:from].include? 'autograph'
    else
      item = Item.where(purchase_id: purchase.id).first
      autograph = Autograph.where(purchase_id: purchase.id).first
    end

    if item
      item.description
    elsif autograph
      autograph.description
    end
  end

  # GET /purchases/1 or /purchases/1.json
  def show
    from_object = params[:from_object]
    Rails.cache.write("from_object", from_object)
    @purchase = Purchase.find(params[:id])
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
    redirect_setup
  end

  # GET /purchases/1/edit
  def edit
    from_object = params[:from_object]
    Rails.cache.write("from_object", from_object)
  end

  def add_purchase_id(purchase_id)
    @from_id = Rails.cache.read("from_id")
    Rails.cache.delete("from_id")
    if @from_id != ''
      if @redirect_path.include? 'item'
        Item.where(id: @from_id, owned_by: user).update({purchase_id: purchase_id})
      elsif @redirect_path.include? 'autograph'
        Autograph.where(id: @from_id, owned_by: user).update({purchase_id: purchase_id})
      end
    end
  end

  # POST /purchases or /purchases.json
  def create    
    @redirect_path = Rails.cache.read("redirect_path")
    if params[:type_name] != ''
      @purchase_type = PurchaseType.new(purchase_type_params)
      @purchase_type.save
      @purchase_type_id = PurchaseType.where(type_name: @purchase_type.type_name).first.id
    else
      @purchase_type_id = params[:purchase][:purchase_type_id]
    end
    
    @purchase = Purchase.new(purchase_params.merge!({
      purchase_type_id: @purchase_type_id, 
      owned_by: user,
      sale_price: purchase_params[:sale_price].gsub(/[^\d\.]/, '').to_f,
      buyer_premium: purchase_params[:buyer_premium].gsub(/[^\d\.]/, '').to_f,
      shipping: purchase_params[:shipping].gsub(/[^\d\.]/, '').to_f,
      additional: purchase_params[:additional].gsub(/[^\d\.]/, '').to_f,
      discount: purchase_params[:discount].gsub(/[^\d\.]/, '').to_f,
      total_cost: total_sale_price}))
    
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
      if @purchase.update(purchase_params.merge!({
        sale_price: purchase_params[:sale_price].gsub(/[^\d\.]/, '').to_f,
        buyer_premium: purchase_params[:buyer_premium].gsub(/[^\d\.]/, '').to_f,
        shipping: purchase_params[:shipping].gsub(/[^\d\.]/, '').to_f,
        additional: purchase_params[:additional].gsub(/[^\d\.]/, '').to_f,
        discount: purchase_params[:discount].gsub(/[^\d\.]/, '').to_f,
        total_cost: total_sale_price}))
        from_object = Rails.cache.read("from_object")
        if from_object         
          Rails.cache.delete("from_object")
          format.html { redirect_to from_object, notice: "Purchase was successfully updated." }
          format.json { render :show, status: :ok, location: from_object }
        else
          format.html { redirect_to @purchase, notice: "Purchase was successfully updated." }
          format.json { render :show, status: :ok, location: @purchase }
        end
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
      @purchase = Purchase.where(owned_by: user).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_params
      params.require(:purchase).permit(:invoice_number, :purchase_type_id, :location, :date, :source, :sale_price, :buyer_premium, :shipping, :additional, :discount, :total_cost)
    end
    def purchase_type_params
      params.permit(:type_name)
    end
end
