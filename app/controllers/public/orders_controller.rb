class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end
  
  def create
    order = Order.new(order_params)
    order.save
    @cart_items = current_customer.cart_items.all
    
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = order.id
      @order_details.item_id = cart_item.item.id
      @order_details.purchase_price = (cart_item.item.price*1.1).floor
      @order_details.amount = cart_item.amount
      @order_details.save
    end
    
    CartItem.destroy_all
    redirect_to orders_success_path
  end
  
  def success
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :amount)
  end
end
