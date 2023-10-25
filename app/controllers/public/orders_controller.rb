class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end
  
  def create
    @order = current_customer.orders.new(order_params)
    @customer = current_customer
  end  
end
