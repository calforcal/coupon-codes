class Merchants::CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @coupons = Coupon.all
    @holidays = HolidayBuilder.build_holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.find(params[:id])

    if @coupon.pending_invoices?
      redirect_to merchant_coupon_path(@merchant, @coupon)
      flash[:alert] = "Coupon cannot be deactivated with invoices pending"
    elsif params[:status] == "1"
      @coupon.update(status: 1)
      redirect_to merchant_coupon_path(@merchant, @coupon)
    elsif params[:status] == "0"
      @coupon.update(status: 0)
      redirect_to merchant_coupon_path(@merchant, @coupon)
    # elsif @coupon.update(coupon_params)
    #   redirect_to merchant_coupon_path(@merchant, @coupon)
    #   flash[:notice] = "Coupon #{@coupon.id} has been successfully updated"
    end
  end

  def new
    @coupon = Coupon.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    if merchant.total_active_coupons < 5
      coupon = merchant.coupons.new(coupon_params)
      if coupon.save
        redirect_to merchant_coupons_path(merchant)
      elsif coupon.code == Coupon.find_by(code: coupon.code).code
        redirect_to new_merchant_coupon_path(merchant)
        flash[:alert] = "Code already is use"
      # else
      #   redirect_to new_merchant_coupon_path(merchant)
      #   flash[:alert] = "Please fill out all fields"
      end
    elsif merchant.total_active_coupons >= 5
      redirect_to new_merchant_coupon_path(merchant)
      flash[:alert] = "Too many active coupons. Please deactivate a current one, or set this one to deactivated."
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :status, :money_off, :coupon_type)
  end
end