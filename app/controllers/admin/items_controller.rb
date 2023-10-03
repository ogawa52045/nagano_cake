class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    @item.admin_id = current_admin.id
    @item.save
    redirect_to item_path(@item)
  end
  
  def index
    @items = Item.all
  end
  
  def show
  end
  
  def edit
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price)
  end
end
