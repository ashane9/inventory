class ApplicationController < ActionController::Base
  helper_method :back, :redirect_setup, :header_name, :session_active?, :user, :clear_all_cache

  def back(default_path)  
    unless Rails.cache.read("redirect_path").nil?
      redirect_path = Rails.cache.read("redirect_path")
      id_arg = Rails.cache.read("from_id")
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

  def clear_redirect
    Rails.cache.delete("redirect_path")
    Rails.cache.delete("from_id")
  end

  def clear_all_cache
    Rails.cache.clear
  end

  private

  def header_name
    if session[:userinfo]
      "#{session[:userinfo]['given_name']}'s Collection"
    else
      "Your Collection"
    end
  end

  def session_active?
    session[:userinfo]
  end

  def user
    session[:userinfo]['name']
  end

end
