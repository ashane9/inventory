class ItemsController < ApplicationController
  include Secured
  before_action :force_json, only: :search
  before_action :set_item, only: %i[ edit update destroy ]

  # GET /items or /items.json
  def index        
    clear_redirect
    @items = Item.where(owned_by: user).all.order(id: :asc)
  end

  # GET /items/1 or /items/1.json
  def show
    redirect_setup
    @item = Item.find(params[:id])
  end

  def search
    q = params[:term].downcase
    items = Item.where(owned_by: user).search_items(q)
    items_json = items.map{|i| {label: "#{i.item_name}: #{i.description}", value: i.item_name, description: i.description, id: i.id}}.to_json
  
    render json: items_json
  end

  # GET /items/new
  def new
    @item = Item.new
    redirect_setup   
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    redirect_path = Rails.cache.read("redirect_path")
    if params[:type_name] != ''
      @item_type = ItemType.new(item_type_params)
      @item_type.save
      @item_type_id = ItemType.where(type_name: @item_type.type_name).first.id
    else
      @item_type_id = params[:item][:item_type_id]
    end
    @item = Item.new(item_params.merge!({item_type_id: @item_type_id, owned_by: user}))

    respond_to do |format|
      if @item.save
        unless redirect_path.nil?
          Rails.cache.delete("redirect_path")
          format.html { redirect_to send redirect_path, from_id: @item.id, notice: "Item was successfully created." }
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
        if params[:item][:image].present?
          params[:item][:image].each do |img|
            @item.image.attach(img)
          end
        end
        format.html { redirect_to @item, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_image_attachment
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_back(fallback_location: request.referer)
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
      @item = Item.where(owned_by: user).find(params[:id])
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