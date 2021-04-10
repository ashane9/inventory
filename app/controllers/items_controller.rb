class ItemsController < ApplicationController
  before_action :force_json, only: :search
  before_action :set_item, only: %i[ show edit update destroy ]
  helper_method :add_new_item_type

  # GET /items or /items.json
  def index        
    clear_redirect
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show
    redirect_setup
    # respond_to do |format|
      
    # end
        # unless params[:from].nil?
      # @redirect_path = "#{params[:from]}" 
      # Rails.cache.write("redirect_path", "#{params[:from]}")
    # end
  end

  def search
    q = params[:q].downcase
    @items = Item.where("LOWER(item_name) LIKE ? or LOWER(description) LIKE ?", "%#{q}%", "%#{q}%").limit(5)
  end

  # GET /items/new
  def new
    @item = Item.new
    redirect_setup
    # unless params[:from].nil?
      # @redirect_path = "#{params[:from]}_path" 
      # Rails.cache.write("redirect_path", @redirect_path)
    # end
    # @item_types = ItemType.all.map{|c| [c.type_name, c.id]}
    #  @item_types += [['Other', -1]] # as there is no negative ID
  end

  # GET /items/1/edit
  def edit
  end

  def add_new_item_type
    # ItemTypesController.new
    #redirect_to item_types_url
    #render 'item_types/_form', item_type: @item_type
    
  end

  # POST /items or /items.json
  def create
    redirect_path = Rails.cache.read("redirect_path")
    puts "WHAT IS TYPENAME: #{params[:type_name]}"
    if params[:type_name] != ''
      @item_type = ItemType.new(item_type_params)
      @item_type.save
      @item_type_id = ItemType.where(type_name: @item_type.type_name).first.id
    else
      @item_type_id = params[:item][:item_type_id]
    end
    # @item = Item.new(item_params.merge!({item_type_id: ItemType.where(type_name: params[:type_name]).first.id}))
    @item = Item.new(item_params.merge!({item_type_id: @item_type_id}))

    respond_to do |format|
      if @item.save
        unless redirect_path.nil?
          Rails.cache.delete("redirect_path")
          puts "redirect_path is deleted in items"
          format.html { redirect_to send redirect_path, notice: "Item was successfully created." }
        else
          format.html { redirect_to @item, notice: "Item was successfully created." }
          format.json { render :show, status: :created, location: @item }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:authenticity_token,:item_name, :description, :item_type_id, :manufacturer, :size, :upc, :image, :purchase)
    end
    def item_type_params
      params.permit(:type_name)
    end
    
  def force_json
    request.format = :json
  end
end