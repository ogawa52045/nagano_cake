class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
    @order_new = Order.new
    render :confirm
  end
  
  def create
  @order = Order.new(order_params)
  @order.customer = current_customer
  
  if @order.save
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = @order.id
      @order_details.item_id = cart_item.item.id
      @order_details.purchase_price = (cart_item.item.price*1.1).floor
      @order_details.amount = cart_item.amount
      @order_details.save!
    end
    CartItem.destroy_all
    redirect_to order_success_path
  else
    render :confirm
  end
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end
  
  def success
  end

  private
  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :amount, :total_price)
  end
  
  def cartitem_nill
    cart_items = current_customer.cart_items
    if cart_items.blank?
      redirect_to cart_items_path
    end
  end
end
