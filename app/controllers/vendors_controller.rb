# app/controllers/vendors_controller.rb

class VendorsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :only_allow_vendors, except: [:new,:create]
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]
  

  def index
    @vendors = Vendor.all
  end

  def show
  end

  def new
    if current_user && current_user.vendor
      flash[:error] = 'You\'re already a vendor.'
      redirect_to vendor_dashboard_url
    else
      @vendor = Vendor.new
    end
  end

  def create
    @vendor = current_user.build_vendor(params.require(:vendor).permit(:business_name, :desc))
    if @vendor.save
      redirect_to vendor_dashboard_url, notice: 'Vendor was successfully created.'
    else
      flash.now[:error] = 'Unable to create Vendor.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @vendor.update(vendor_params)
      redirect_to @vendor, notice: 'Vendor was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @vendor.destroy
    redirect_to vendors_url, notice: 'Vendor was successfully destroyed.'
  end

  def dashboard
    @vendor = current_user.vendor
    @potions = @vendor.potions
    @orders = @vendor.related_orders.order(created_at: :desc)
  end

  private

  def set_vendor
    @vendor = current_user.vendor
  end

  def vendor_params
    params.require(:vendor).permit(:name, :business_name, :contact, :email, :phone_number, :password, :password_confirmation)
  end  
  protected

  def after_sign_in_path_for(resource)
    # Check if the resource is a vendor and redirect to the dashboard
    if resource.instance_of?(Vendor)
      vendor_dashboard_path
    else
      super
    end
  end

  def only_allow_vendors
    if current_user && !current_user.vendor
      flash[:error] = 'You do not have permission to do that.'
      redirect_to root_url
    end
  end


end