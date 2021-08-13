class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy,]

  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
  end

  # POST /orders/finalize
  def finalize
    @order = current_user.active_order
    return render json: { message: 'You currently have no active order!' } if @order.blank?

    @order.finalize!

    render json: {
      message: 'Order is finalized successfully!',
      order: @order, order_products: @order.order_products }
  end

  # GET /orders/current
  def current
    @order = current_user.active_order

    return render json: { message: 'You currently have no active order!' } if @order.blank?

    render json: { order: @order, order_products: @order.order_products, total_price: @order.total_price }
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:user_id)
  end
end
