class Public::CartItemsController < ApplicationController
  def new
    @cart_items = Cart_item.new
  end
  
  private
  
  def cart_item_params
    prams.require(:cart_item).permit(:item_id, :amount)
  end
end
