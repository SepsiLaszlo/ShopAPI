class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products

  def add(product:, quantity:)
    raise "Order is already finalized!" if finalized?

    OrderProduct.create!(product: product,
                         quantity: quantity,
                         order: self)
  end

  def finalize!
    ActiveRecord::Base.transaction do
      order_products.each do |order_product|
        product = order_product.product
        ordered_quantity = order_product.quantity
        product.update!(quantity: product.quantity - ordered_quantity)
      end
      update!(finalized: true)
    end
  end

  def self.for(user)
    ActiveRecord::Base.transaction do
      Order.find_or_create_by!(user: user, finalized: false)
    end
  end
end
