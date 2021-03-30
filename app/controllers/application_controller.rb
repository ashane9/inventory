class ApplicationController < ActionController::Base
  helper_method :back, :redirect_setup

  def back(default_path)    
    redirect_path = Rails.cache.read("redirect_path")
    id_arg = Rails.cache.read("from_id")
    unless redirect_path.nil?
      Rails.cache.delete("redirect_path")
      send(redirect_path, id_arg)
    else
      send default_path
    end
  end

  def redirect_setup  
    unless params[:from].nil?
      from_id = params[:from_id]
      redirect_path = "#{params[:from]}" 
      Rails.cache.write("redirect_path", redirect_path)
      Rails.cache.write("from_id", from_id)
    end
  end

end
