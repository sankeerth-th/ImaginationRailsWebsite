class PotionsController < ApplicationController
  before_action :set_potion, only: [:show, :edit, :update, :destroy]
  before_action :check_vendor, only: [:edit, :update, :destroy]
  before_action :ensure_vendor, only: [:vendor_show]

  # GET /potions
  def index
    @potions = Potion.all
  
    # Search by name
    if params[:search].present?
      @potions = @potions.where('LOWER(name) LIKE ?', "%#{params[:search].downcase}%")
    end
  
    # Filter by category
    if params[:category].present?
      @potions = @potions.where(category: params[:category])
    end
  
    # Filter by potency
    if params[:potency].present?
      @potions = @potions.where(potency: params[:potency])
    end
  
    if params[:min_price].present? && params[:max_price].present?
      min_price = params[:min_price].to_f
      max_price = params[:max_price].to_f
      @potions = @potions.where('price >= ? AND price <= ?', min_price, max_price)
    elsif params[:min_price].present?
      min_price = params[:min_price].to_f
      @potions = @potions.where('price >= ?', min_price)
    elsif params[:max_price].present?
      max_price = params[:max_price].to_f
      @potions = @potions.where('price <= ?', max_price)
    end
    
  
    # Filter by origin
    if params[:origin].present?
      @potions = @potions.where(origin: params[:origin])
    end

    respond_to do |format|
      format.html # For regular requests
      format.js { render layout: false } # For AJAX requests
    end
  end
  

  # GET /potions/1
  def show
  end

  # GET /potions/new
  def new
    @potion = Potion.new
  end

  # GET /potions/1/edit
  def edit
  end

  # POST /potions
  def create
    # Get the vendor associated with the current user
    vendor = current_user.vendor

    # Check if the current user is associated with a vendor
    if vendor
      @potion = vendor.potions.new(potion_params)
      if @potion.save
        redirect_to vendor_dashboard_path, notice: 'Potion was successfully created.'
      else
        render :new
      end
    else
      # Redirect or render an error if the current user is not associated with a vendor
      redirect_to root_path, alert: 'You must be a vendor to create potions.'
    end
  end


  # PATCH/PUT /potions/1
  def update
    if @potion.update(potion_params)
      redirect_to vendor_dashboard_path, notice: 'Potion was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /potions/1
  def destroy
    @potion.destroy
    redirect_to vendor_dashboard_path, notice: 'Potion was successfully destroyed.'
  end

  private

  def set_potion
    @potion = Potion.find(params[:id])
  end

  def potion_params
    params.require(:potion).permit(:name, :effect, :source_description, :origin, :potency, :duration, :category, :recommended_age, :vendor_id, :price, :stock, images: [])
  end

  def check_vendor
    redirect_to vendor_dashboard_path, alert: 'Not authorized' if @potion.vendor.userobj != current_user
  end

  def ensure_vendor
    # Logic to verify if the current user is a vendor
    unless current_user.vendor
      flash[:error] = 'You do not have permission to do that.'
      redirect_to root_url
    end
  end

  def vendor_show
    puts "Potion ID: #{params[:id]}"
    @potion = Potion.find_by(id: params[:id])

    if @potion.nil?
      redirect_to some_error_path, alert: 'Potion not found'
    end
  end
end