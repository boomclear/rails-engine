require 'rails_helper'

RSpec.describe "Merchant item Index" do
  describe "Merchant item index API Request", :vcr do
    it 'displays all merchants items in json-api compliance' do
      m1 = Merchant.create!(name: "The Shop")
      Item.create!(name: "Item 1", description: "Lorem Ipsum", unit_price: 102.0, merchant_id: m1.id)
      Item.create!(name: "Item 2", description: "Lorem Ipsum", unit_price: 102.0, merchant_id: m1.id)
      Item.create!(name: "Item 3", description: "Lorem Ipsum", unit_price: 102.0, merchant_id: m1.id)
      Item.create!(name: "Item 4", description: "Lorem Ipsum", unit_price: 102.0, merchant_id: m1.id)
      get("/api/v1/merchants/#{m1.id}/items")

      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(items[:data].count).to eq(4)
     
      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes]).to have_key(:merchant_id)
      end
    end
  end
end