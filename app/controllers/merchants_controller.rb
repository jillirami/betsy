class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all.order(:id)
  end

  def show
    @merchant = Merchant.find_by(id: session[:merchant_id])

    if @merchant.nil?
      flash[:error] = "Unknown merchant"

      redirect_to merchants_path
    end
  end

  def create ##
    auth_hash = request.env["omniauth.auth"]

    merchant = Merchant.find_by(uid: auth_hash[:uid], provider: "github")

    if merchant
      flash[:success] = "Logged in as a returning merchant #{merchant.username}"
    else
      merchant = Merchant.build_from_github(auth_hash)

      if merchant.save
        flash[:success] = "Logged in as new merchant #{merchant.username}"
      else
        flash[:error] = "Could not create new merchant account: #{merchant.errors.messages}"
        return redirect_to root_path
      end
    end

    session[:merchant_id] = merchant.id
    redirect_to root_path
  end

  def current #
    @merchant = Merchant.find_by(id: session[:merchant_id])
    if @merchant.nil?
      flash[:error] = "You must be logged in first!"
      redirect_to root_path
    end
  end

  def logout #
    merchant = Merchant.find_by(id: session[:merchant_id])
    session[:merchant_id] = nil
    flash[:success] = "Successfully logged out, #{merchant.username}!"
    redirect_to root_path
  end
end
