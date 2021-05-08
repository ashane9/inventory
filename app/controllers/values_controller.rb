class ValuesController < ApplicationController
  include Secured
  before_action :set_value, only: %i[ show edit update destroy ]
  helper_method :get_value_name, :get_value_description, :get_item_info, :get_autograph_info

  # GET /values or /values.json
  def index
    clear_redirect
    @values = Value.where(owned_by: user).all
  end
  
  def get_item_info    
    Item.where(id: params[:from_id]).first
  end

  def get_autograph_info
    Autograph.where(id: params[:from_id]).first
  end

  def get_value_name(value)    
    if value.id.nil?
      item = get_item_info if params[:from].include? 'item'
      autograph = get_autograph_info if params[:from].include? 'autograph'
    else
      item = Item.where(value_id: value.id).first
      autograph = Autograph.where(value_id: value.id).first
    end

    if item
      item.item_name
    elsif autograph
      autograph.name
    end
  end

  def get_value_description(value)        
    if value.id.nil?
      item = get_item_info if params[:from].include? 'item'
      autograph = get_autograph_info if params[:from].include? 'autograph'
    else
      item = Item.where(value_id: value.id).first
      autograph = Autograph.where(value_id: value.id).first
    end

    if item
      item.description
    elsif autograph
      autograph.description
    end
  end

  # GET /values/1 or /values/1.json
  def show
    from_object = params[:from_object]
    Rails.cache.write("from_object", from_object)
  end

  # GET /values/new
  def new
    @value = Value.new
    redirect_setup
  end

  # GET /values/1/edit
  def edit
    from_object = params[:from_object]
    Rails.cache.write("from_object", from_object)
  end

  def add_value_id(value_id)
    @from_id = Rails.cache.read("from_id")
    Rails.cache.delete("from_id")
    if @from_id != ''
      if @redirect_path.include? 'item'
        Item.where(id: @from_id, owned_by: user).update({value_id: value_id})
      elsif @redirect_path.include? 'autograph'
        Autograph.where(id: @from_id, owned_by: user).update({value_id: value_id})
      end
    end
  end

  # POST /values or /values.json
  def create
    @redirect_path = Rails.cache.read("redirect_path")
    
    @value = Value.new(value_params.merge!({
      owned_by: user,
      estimated_value: value_params[:estimated_value].gsub(/[^\d\.]/, '').to_f
      }))

    respond_to do |format|
      if @value.save

        add_value_id(@value.id)
        unless @redirect_path.nil? or @redirect_path.eql? 'new_purchase_path'
          if @from_id.nil?
            format.html { redirect_to send @redirect_path, notice: "Value was successfully created." }
          else
            format.html { redirect_to send @redirect_path, @from_id, notice: "Value was successfully created." }
          end
          Rails.cache.delete("redirect_path")
          puts "redirect_path is deleted in values"
        else  
          format.html { redirect_to @value, notice: "Value was successfully created." }
          format.json { render :show, status: :created, location: @value }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /values/1 or /values/1.json
  def update
    respond_to do |format|
      if @value.update(value_params.merge!({
        estimated_value: value_params[:estimated_value].gsub(/[^\d\.]/, '').to_f
        }))
        from_object = Rails.cache.read("from_object")
        if from_object
          Rails.cache.delete("from_object")
          format.html { redirect_to from_object, notice: "Value was successfully updated." }
          format.json { render :show, status: :ok, location: from_object }
        else
          format.html { redirect_to @value, notice: "Value was successfully updated." }
          format.json { render :show, status: :ok, location: @value }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /values/1 or /values/1.json
  def destroy
    @value.destroy
    respond_to do |format|
      format.html { redirect_to values_url, notice: "Value was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_value
      @value = Value.where(owned_by: user).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def value_params
      params.require(:value).permit(:estimated_value, :as_of_date)
    end
end
