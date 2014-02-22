class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin_only!
    redirect_to root_path unless current_user.id == 1
  end
end
