class HomeController < ApplicationController
  def index
    @user = session[:userinfo]
  end
  
  def new_autograph
  end

  def reset
    reset_session
  end

end
