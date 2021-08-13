class
  ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy, :add_to_order]

  # GET /products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products/1/add_to_order
  def add_to_order
    quantity = params[:quantity].to_i
    quantity = 1 if quantity.blank?

    order_product = current_user.add_to_order(product: @product, quantity: quantity)

    render json: { message: 'Product successfully added to your order!',
                   product: order_product }
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :price, :quantity)
  end
end
