require 'rails_helper'

RSpec.describe "Users", type: :request do
  before(:each) do
    User.create!(email: 'admin@test.com')
    User.create!(email: 'customer@test.com')

    Product.create!(name: 'cinnamon roll',
                    price: 150,
                    quantity: 5)

    Product.create!(name: 'apple',
                    price: 100,
                    quantity: 10)
  end

  it 'login' do
    post '/users/2/login'

    post '/products/1/add_to_order', params: { quantity: 2 }
    post '/products/2/add_to_order', params: { quantity: 3 }

    get '/orders/current'
    body = JSON.parse(response.body)
    expect(body['total_price']).to eq(600)
  end
end
