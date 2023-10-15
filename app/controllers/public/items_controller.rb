class Public::ItemsController < ApplicationController
  def new
  end

  def index
   @items = Item.all
  end

  def show
   @item = Item.find(params[:id])
   @cart_item =CartItem
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end
  
end
