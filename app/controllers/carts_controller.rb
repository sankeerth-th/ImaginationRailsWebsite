class CartsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_cart
  
    # GET /cart
    def show
        @cart = current_user.cart || current_user.create_cart
    end
  
    private
  
    def set_cart
      @cart = current_user.cart || current_user.create_cart
    end
  end
  