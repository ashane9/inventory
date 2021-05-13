class HomeController < ApplicationController
  def index
    @user = session[:userinfo]
    clear_all_cache
  end
  
  def new_autograph
  end

  def reset
    reset_session
  end

  def support
  end

end
