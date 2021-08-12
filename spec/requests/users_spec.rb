require 'rails_helper'

RSpec.describe "Users", type: :request do
  it 'login' do
    user = User.create(email: 'user@test.com')

    get '/users/1/login'
    get '/users/current'

    email = JSON.parse(response.body)['email']
    expect(email).to eq('user@test.com')
  end

end
