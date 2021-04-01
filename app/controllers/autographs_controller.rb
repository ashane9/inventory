class AutographsController < ApplicationController
  before_action :set_autograph, only: %i[ show edit update destroy ]

  # GET /autographs or /autographs.json
  def index
    @autographs = Autograph.all
  end

  def get_item
    puts params[:item_id]
    Rails.cache.write("item_id", params[:item_id])
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
    redirect_path = Rails.cache.read("redirect_path")
    item_id = Rails.cache.read("item_id")
    authentication_id = nil
    Rails.cache.delete("item_id")

    @autograph = Autograph.new(autograph_params.merge!({item_id: item_id }))

    respond_to do |format|
      if @autograph.save
        if params[:name] != ''
          authentication = Authentication.new(authentication_params)
          authentication.save
          authentication_id = Authentication.where(name: authentication.name).first.id
        elsif params[:autograph][:authentication_id] != ''
          authentication_id = params[:autograph][:authentication_id]
        end

        unless authentication_id.nil?
          merged_params = autograph_authentication_params.merge!({autograph_id: @autograph.id, 
          authentication_id: authentication_id, 
          authentication_number: params[:authentication_number]})
          autograph_authentication = AuthenticationsAutograph.new(merged_params)
          autograph_authentication.save
        end
        
        unless redirect_path.nil?
          Rails.cache.delete("redirect_path")
          format.html { redirect_to send redirect_path, notice: "Autograph was successfully created." }
        else
          format.html { redirect_to @autograph, notice: "Autograph was successfully created." }
          format.json { render :show, status: :created, location: @autograph }
        end
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
      params.require(:autograph).permit(:name, :item_id)
    end
    
    def authentication_params
      params.permit(:name)
    end

    def autograph_authentication_params
      params.permit(:authentication_number)
    end
end
