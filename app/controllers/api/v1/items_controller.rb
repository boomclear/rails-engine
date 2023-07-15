class Api::V1::ItemsController < ApplicationController
  
  def merchant_index
    merchant = Merchant.find(params[:merchant_id])
    items = merchant.items
    render json: ItemSerializer.new(items)
  end

  def index
    items = Item.all

    render json: ItemSerializer.new(items)
  end

  def show 
    item = Item.find(params[:id])

    render json: ItemSerializer.new(item)
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: :created
    end
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)

    render json: ItemSerializer.new(item)
  end

  def destroy
    item = Item.find(params[:id])
    item.delete
  end

  def merchant_show
    item = Item.find(params[:id])
    merchant = item.merchant
    render json: MerchantSerializer.new(merchant)
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end 