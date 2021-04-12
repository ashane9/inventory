class AutographsController < ApplicationController
  include Secured
  before_action :set_autograph, only: %i[ show edit update destroy ]

  # GET /autographs or /autographs.json
  def index
    clear_redirect
    @autographs = Autograph.where(owned_by: user).all
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
    
    if params[:profession_name] != ''
      @profession = Profession.new(profession_params)
      @profession.save
      @profession_id = Profession.where(profession_name: @profession.profession_name).first.id
    else
      @profession_id = params[:autograph][:profession_id]
    end
    if params[:org_name] != ''
      @organization = Organization.new(organization_params)
      @organization.save
      @organization_id = Organization.where(org_name: @organization.org_name).first.id
    else
      @organization_id = params[:autograph][:organization_id]
    end


    @autograph = Autograph.new(autograph_params.merge!({item_id: item_id, 
      profession_id: @profession_id, organization_id: @organization_id, owned_by: user }))

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
          authentication_number: params[:authentication_number],
          owned_by: user})
          autograph_authentication = AuthenticationsAutograph.new(merged_params)
          autograph_authentication.save
        end
                
        Rails.cache.delete("redirect_path")
        puts "redirect_path is deleted in autographs"
        unless redirect_path.nil? or redirect_path.eql? 'new_autograph_path'
          if item_id.nil?
            format.html { redirect_to send redirect_path, notice: "Autograph was successfully created." }
          else
            format.html { redirect_to send redirect_path, item_id, notice: "Autograph was successfully created." }
          end
          Rails.cache.delete("redirect_path")
          puts "redirect_path is deleted in autographs"
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
      @autograph = Autograph.where(owned_by: user).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def autograph_params
      params.require(:autograph).permit(:name, :item_id, :profession_id, :organization_id)
    end
    
    def authentication_params
      params.permit(:name)
    end

    def autograph_authentication_params
      params.permit(:authentication_number)
    end

    def profession_params
      params.permit(:profession_name)
    end

    def organization_params
      params.permit(:org_name)
    end
end
