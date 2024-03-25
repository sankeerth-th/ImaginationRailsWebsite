class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:new, :create]
  before_action :check_vendor_authorization, only: [:mark_as_shipped, :cancel]
  
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end
  
  def new
    @order = Order.new
    redirect_to cart_path, notice: "Your cart is empty." if @cart.cart_items.empty?
  end
  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = calculate_total(@cart)
    @order.status = 'Pending'
    if @order.save
      create_order_items(@order, @cart)
      clear_cart(@cart)
      redirect_to order_path(@order), notice: 'Order was successfully created.'
    else
      render :new
    end
  end
  
  def show
    @order = Order.find(params[:id])
  end
  def mark_as_shipped
    order = Order.find(params[:id])
    if order.potions.any? { |potion| potion.vendor.user_id == current_user.id }
      order.update(status: 'Shipped')
      redirect_to vendor_dashboard_url, notice: 'Order marked as shipped.'
    else
      redirect_to vendor_dashboard_url, alert: 'Not authorized.'
    end
  end
  def cancel
    order = Order.find(params[:id])
    if order.potions.any? { |potion| potion.vendor.user_id == current_user.id }
      order.update(status: 'Cancelled')
      order.order_items.each do |order_item|
        potion = order_item.potion
        potion.stock += order_item.quantity
        potion.save
      end
      redirect_to vendor_dashboard_url, notice: 'Order cancelled.'
    else
      redirect_to vendor_dashboard_url, alert: 'Not authorized.'
    end
  end

  def cancel_by_user
    order = Order.find(params[:id])

    # Check if the current user is the order creator
    if order.user == current_user
      order.update(status: 'Cancelled')
      order.order_items.each do |order_item|
        potion = order_item.potion
        potion.stock += order_item.quantity
        potion.save
      end
      redirect_to orders_path, notice: 'Your order has been cancelled.'
    else
      redirect_to orders_path, alert: 'You are not authorized to cancel this order.'
    end
  end
  private
  def order_params
    params.require(:order).permit(:shipping_address, :payment_method, :card_number, :expiry_date, :cvv)
  end
  
  def set_cart
    @cart = current_user.cart
  end
  def calculate_total(cart)
    cart.cart_items.sum { |item| item.quantity * item.potion.price }
  end
  def create_order_items(order, cart)
    cart.cart_items.each do |cart_item|
      order.order_items.create!(
        potion_id: cart_item.potion_id,
        quantity: cart_item.quantity,
        total_price: cart_item.quantity * cart_item.potion.price)
      stock = cart_item.potion
      stock.stock -= cart_item.quantity
      stock.save
      end
    end
  end

  def check_vendor_authorization
    order = Order.find(params[:id])
    unless order.potions.any? { |potion| potion.vendor.userobj.id == current_user.id }
      redirect_to vendor_dashboard_url, alert: 'Not authorized to modify this order.'
    end
  end
  def clear_cart(cart)
    cart.cart_items.destroy_all
  end
