class Merchants::CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @coupons = Coupon.all
  end

  def new
    @coupon = Coupon.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    coupon = merchant.coupons.new(coupon_params)
    if coupon.save
      redirect_to merchant_coupons_path(merchant)
    else
      redirect_to new_merchant_coupon_path(merchant)
      flash[:alert] = "Please fill out all fields"
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :status, :money_off, :coupon_type)
  end
end