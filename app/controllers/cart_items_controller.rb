class CartItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_cart, only: [:create]
    before_action :set_cart_item, only: [:show, :edit, :update, :destroy]
    before_action :verify_cart_ownership, only: [:show, :edit]
  
    # POST /cart_items
    def create
        potion = Potion.find(params[:potion_id])
        quantity = params[:quantity].to_i
    
        @cart_item = @cart.cart_items.find_or_initialize_by(potion: potion)
        @cart_item.quantity ||= 0 # Initialize quantity to 0 if it's nil
        @cart_item.quantity += quantity
        if @cart_item.quantity > @cart_item.potion.stock
          redirect_to potion_path(potion), alert: 'Not enough stock to add item to cart.'
        elsif @cart_item.save
          redirect_to cart_path, notice: 'Item added to cart.'
        else
          redirect_to potion_path(potion), alert: 'Unable to add item to cart.'
        end
    end
    def show
        # Logic already implemented in set_cart_item
    end
    
    def edit
        # Logic already implemented in set_cart_item
    end
  
    # PATCH/PUT /cart_items/:id
    def update
      new_quantity = params[:quantity].to_i
      if new_quantity > @cart_item.potion.stock
        redirect_to cart_path, alert: 'Not enough stock to add item to cart.'
      elsif new_quantity > 0
        @cart_item.update(quantity: new_quantity)
        redirect_to cart_path, notice: 'Cart item updated.'
      else
        redirect_to cart_path, alert: 'Invalid quantity.'
      end
    end
  
    # DELETE /cart_items/:id
    def destroy
      @cart_item.destroy
      redirect_to cart_path, notice: 'Item removed from cart.'
    end
  
    private
  
    def set_cart
        @cart = current_user.cart || current_user.create_cart
    end
    
    def set_cart_item
        # Directly find the CartItem without depending on @cart
        @cart_item = CartItem.find(params[:id])
    end
    
    def verify_cart_ownership
        unless @cart_item.cart.user == current_user
          redirect_to root_path, alert: "You are not authorized to view this page."
        end
    end
end
  