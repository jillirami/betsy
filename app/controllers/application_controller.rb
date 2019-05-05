class ApplicationController < ActionController::Base
  before_action :find_merchant

  def find_merchant
    @current_merchant = Merchant.find_by(id: session[:merchant_id])
  end

  def require_login
    current_user = find_merchant
    if current_user.nil?
      flash[:error_form] = "You must be logged in to do this action"
      redirect_to root_path
    end
  end
end
