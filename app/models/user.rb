class User < ApplicationRecord
  has_many :orders

  def add_to_order(product:, quantity: 1)
    ActiveRecord::Base.transaction do
      order = Order.for(self)
      order_product = OrderProduct.find_or_create_by!(order: order, product: product)
      order_product.quantity = 0 if order_product.quantity.blank?
      order_product.quantity += quantity
      order_product.save!

      order_product
    end
  end

  def active_order
    Order.includes(:order_products).where(user: self , finalized: false).last
  end
end
