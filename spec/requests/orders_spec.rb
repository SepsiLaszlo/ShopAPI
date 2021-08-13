require 'rails_helper'

RSpec.describe "Orders", type: :request do
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

  # HINT:
  # Use the debugger and inspect the variables (shift + F9)
  # ctrl + shift + F - search in all files
  # ctrl + B - go to definition
  # extra: ctrl + W - select around cursor, double press to extend selection

  it 'calculates the correct total_price' do
    post '/users/2/login'
    post '/products/1/add_to_order', params: { quantity: 2 }
    post '/products/2/add_to_order', params: { quantity: 3 }

    get '/orders/current'
    body = JSON.parse(response.body)

    # expected result: 600 = 150 * 2 + 100 * 3
    expect(body['total_price']).to eq(600)
  end
end
