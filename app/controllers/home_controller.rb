class HomeController < ApplicationController
  def index
    @user = session[:userinfo]
    clear_all_cache
  end
  
  def new_autograph
  end

  def search    
    @items = []
    @autographs = []
    if params[:search].blank?
      # render inline: '<p>No Results Found</p>'
    else
      puts "#{params[:search][:item_type]}"
      search_text = params[:search][:search_text].downcase
      date_compare = {'Equal to': '=', 'Before': '<', 'After': '>'}
      unless params[:search][:purchase_date] == ''
        purchases_query = "purchase_date #{date_compare[params[:search][:purchase_comparison]]} '#{params[:search][:purchase_date]}'"
        purchases_query = purchases_query + " and owned_by = '#{params[:search][:owned_by]}'" unless params[:search][:owned_by] == ""
        @purchases = Purchase.where(purchases_query)
      end

      item_query = "(lower(item_name) LIKE '%#{search_text}%' or lower(description) LIKE '%#{search_text}%')"
      item_query = item_query + " and item_type_id in (#{params[:search][:item_type].join(',')})" unless params[:search][:item_type].nil?
      item_query = item_query + " and purchase_id in (#{@purchases.map{|purchase| purchase.id}.join(',')})" unless @purchases.nil? or @purchases.count == 0
      item_query = item_query + " and manufacturer in (#{params[:search][:manufacturer].compact.reject{|a| a==""}.map{|x|"'#{x}'"}.join(',')})" unless params[:search][:manufacturer].compact.reject{|a| a==""}.empty?
      item_query = item_query + " and size_id in (#{params[:search][:size].join(',')})" unless params[:search][:size].nil?
      item_query = item_query + " and owned_by = '#{params[:search][:owned_by]}'" unless params[:search][:owned_by] == ""
      @items = Item.where(item_query) unless params[:search][:type] == 'Autograph'
      
      autograph_query = "(lower(name) LIKE '%#{search_text}%' or lower(description) LIKE '%#{search_text}%')"
      autograph_query = autograph_query + " and item_id in (#{@items.map{|item| item.id}.join(',')})" unless @items.count == 0
      autograph_query = autograph_query + " and profession_id in (#{params[:search][:profession_name].compact.reject{|a| a==""}.join(',')})" unless params[:search][:profession_name].compact.reject{|a| a==""}.empty?
      autograph_query = autograph_query + " and organization_id in (#{params[:search][:org_name].compact.reject{|a| a==""}.join(',')})" unless params[:search][:org_name].compact.reject{|a| a==""}.empty?
      autograph_query = autograph_query + " and purchase_id in (#{@purchases.map{|purchase| purchase.id}.join(',')})" unless @purchases.nil? or @purchases.count == 0
      autograph_query = autograph_query + " and autograph_date #{date_compare[params[:search][:autograph_comparison].to_sym]} '#{params[:search][:autograph_date]}'" unless params[:search][:autograph_date] == ''
      autograph_query = autograph_query + " and owned_by = '#{params[:search][:owned_by]}'" unless params[:search][:owned_by] == ""
      puts autograph_query
      @autographs = Autograph.where(autograph_query) unless params[:search][:type] == 'Item'
    end
  end

  def reset
    reset_session
  end

  def support
  end

end
