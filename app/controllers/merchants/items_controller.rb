class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(@item.merchant_id)
    # @item_photo = PhotoBuilder.item_photo_info(@item.name)
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = Merchant.find(@item.merchant_id)
  end

  def update
    item = Item.find(params[:id])
    if params[:status] == "0"
      item.update(status: 0)
      redirect_to merchant_items_path(item.merchant_id)
    elsif params[:status] == "1"
      item.update(status: 1)
      redirect_to merchant_items_path(item.merchant_id)
    else
      item.update(item_params)
      redirect_to merchant_item_path(item.merchant_id, item)
      flash[:notice] = "Item #{item.name} Successfully Updated!"
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = @merchant.items.new(item_params)
    if item.save
      redirect_to merchant_items_path(@merchant)
    else
      redirect_to new_merchant_item_path(@merchant)
      flash[:alert] = "Please fill out all fields"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end