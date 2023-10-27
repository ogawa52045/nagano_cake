class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_member.id
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end

  private
  def order_params
    params.require(:order).permit(:payment_method)
  end
end
