class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    # @merchant_photo = PhotoBuilder.merchant_photo_info(@merchant.name)
  end
end
