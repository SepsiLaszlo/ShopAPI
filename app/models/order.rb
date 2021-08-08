class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products

  def add(product:, quantity:)
    raise "Order is already finalized!" if finalized?

    OrderProduct.create!(product: product,
                         quantity: quantity,
                         order: self )
  end

  def finalize!

  end
end
