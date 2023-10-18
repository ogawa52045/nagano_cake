class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def new
     @cart_item = CartItem.new
  end
  
  def index
    @cart_items = current_customer.cart_items.all
  end
  
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save
      @cart_items = current_customer.cart_items.all
      render 'index'
    else
      render 'index'
    end
  end
  
   def increase
    @cart_item.increment!(:amount, 1)
    redirect_to request.referer
   end

  def decrease
    decrease_or_destroy(@cart_item)
    redirect_to request.referer
  end
  
  private
  
  def increase_or_create(item_id)
    cart_item = current_customer.cart_items.find_by(item_id:)
    if cart_item
      cart_item.increment!(:amount, 1)
    else
      current_customer.cart_items.build(item_id:).save
    end
  end

  def decrease_or_destroy(cart_item)
    if cart_item.amount > 1
      cart_item.decrement!(:amount, 1)
    else
      cart_item.destroy
    end
  end
 
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :price, :amount, :image)
  end
end
