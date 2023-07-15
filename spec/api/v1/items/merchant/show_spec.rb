require 'rails_helper'

RSpec.describe "show item merchant" do
  describe "item merchant API Request", :vcr do
    it 'item merchant in json-api compliance' do
      m1 = Merchant.create!(name: "The Shop")
      i1 = Item.create!(name: "Item 18", description: "Lorem Ipsum", unit_price: 34.00, merchant_id: m1.id)
      get "/api/v1/items/#{i1.id}/merchant"

      expect(response).to be_successful
      merch = JSON.parse(response.body, symbolize_names: true)
     
      expect(merch[:data][:attributes][:name]).to eq(i1.merchant.name)
    end
  end
end