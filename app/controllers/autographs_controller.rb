class AutographsController < ApplicationController
  include Secured
  before_action :set_autograph, only: %i[ show edit update destroy ]
  helper_method :get_item_id, :cancel, :link_to_cancel

  # GET /autographs or /autographs.json
  def index
    clear_redirect
    @autographs = Autograph.where(owned_by: user).all
  end

  def cancel(root_path)
    root_path
  end

  # used in autograph/_form.html
  def get_item_id
    if Rails.cache.read("item_id").nil?
      item_id = @autograph.item_id
    else
      item_id = Rails.cache.read("item_id")
    end
    Item.where(id: item_id).first   

  end

  #used in ajax call for js autocomplete search
  def get_item
    Rails.cache.write("item_id", params[:item_id])
  end

  # GET /autographs/1 or /autographs/1.json
  def show
      redirect_setup
  end

  # GET /autographs/new
  def new
    @autograph = Autograph.new
    @authentication_autograph = @autograph.authentications_autographs
    
    unless params[:from_id].nil?
      @item = Item.where(id: params[:from_id]).first    
      Rails.cache.write("item_id", params[:from_id]) 
    end
    redirect_setup
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
    @authentication_autograph = @autograph.authentications_autographs
    #statement builds record in the join table and once save is executed records are inserted in both tables
    if params[:autograph][:authentications_autographs]
      params[:autograph][:authentications_autographs].each do |k,v|      
        if v[:auth_name] != ''
          authentication = Authentication.new(auth_name: v[:auth_name])
          authentication.save
          v[:authentication_id] = authentication.id
        end
        @autograph.authentications_autographs.build(authentication_id: v[:authentication_id],
          authentication_number: v[:authentication_number], owned_by: user)        
      end
    end
    
    respond_to do |format|
      if @autograph.save
                
        Rails.cache.delete("redirect_path")
        unless redirect_path.nil? or redirect_path.eql? 'new_autograph_path'
          if item_id.nil?
            format.html { redirect_to send redirect_path, notice: "Autograph was successfully created." }
          else
            format.html { redirect_to send redirect_path, item_id, notice: "Autograph was successfully created." }
          end
          Rails.cache.delete("redirect_path")
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
    if params[:profession_name] != ''
      @profession = Profession.new(profession_params)
      @profession.save
      @profession_id = @profession.id
    else
      @profession_id = params[:autograph][:profession_id]
    end
    if params[:org_name] != ''
      @organization = Organization.new(organization_params)
      @organization.save
      @organization_id = @organization.id
    else
      @organization_id = params[:autograph][:organization_id]
    end

    params[:autograph][:authentications_autographs].each do |k,v|      
      if v[:auth_name] != ''
        authentication = Authentication.new(auth_name: v[:auth_name])
        authentication.save
        v[:authentication_id] = authentication.id
      end
      AuthenticationsAutograph.upsert(
        {authentication_id: v[:authentication_id],autograph_id: @autograph.id,authentication_number: v[:authentication_number], owned_by: user},
      unique_by: [:authentication_id, :autograph_id])        
    end
    
    respond_to do |format|
      if @autograph.update(autograph_params.merge!({ 
        profession_id: @profession_id, organization_id: @organization_id, owned_by: user }))

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
      @authentication_autograph = AuthenticationsAutograph.where(autograph_id: @autograph.id, owned_by: user)
    end

    # Only allow a list of trusted parameters through.
    def autograph_params
      params.require(:autograph).permit(:name, :item_id, :profession_id, :image, :organization_id, 
        :description, :inscription, :autograph_date, authentications_autographs_attributes: AuthenticationsAutograph.attribute_names.map(&:to_sym))
    end

    def authentication_autograph_params
      params.permit(:authentication_number)
    end

    def profession_params
      params.permit(:profession_name)
    end

    def organization_params
      params.permit(:org_name)
    end
end
