class ValuesController < ApplicationController
  include Secured
  before_action :set_value, only: %i[ show edit update destroy ]

  # GET /values or /values.json
  def index
    clear_redirect
    @values = Value.where(owned_by: user).all
  end

  # GET /values/1 or /values/1.json
  def show
  end

  # GET /values/new
  def new
    @value = Value.new
    redirect_setup
  end

  # GET /values/1/edit
  def edit
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
    
    @value = Value.new(value_params.merge!({owned_by: user})

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
      if @value.update(value_params)
        format.html { redirect_to @value, notice: "Value was successfully updated." }
        format.json { render :show, status: :ok, location: @value }
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
