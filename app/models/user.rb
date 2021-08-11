class User < ApplicationRecord
  has_many :orders

  def add_to_order(product:, quantity: 1)
    order = Order.for(self)
    order.add(product: product, quantity: quantity)
  end
end
