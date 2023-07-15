require 'rails_helper'

RSpec.describe 'item show' do
  describe 'item show API Request', :vcr do
    it 'displays a item in json-api compliance' do
      m1 = Merchant.create!(name: 'The Shop')
      i1 = Item.create!(name: 'Item 1', description: 'Lorem Ipsum', unit_price: 102.0, merchant_id: m1.id)
      Item.create!(name: 'Item 2', description: 'Lorem Ipsum', unit_price: 102.0, merchant_id: m1.id)
      Item.create!(name: 'Item 3', description: 'Lorem Ipsum', unit_price: 102.0, merchant_id: m1.id)
      Item.create!(name: 'Item 4', description: 'Lorem Ipsum', unit_price: 102.0, merchant_id: m1.id)
      get("/api/v1/items/#{i1.id}")

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item[:data]).to have_key(:id)
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes]).to have_key(:merchant_id)
    end
  end
end
