require 'rails_helper'

RSpec.describe "Merchant show" do
  describe "Merchant show API Request", :vcr do
    it 'displays one merchants in json-api compliance' do
      m1 = Merchant.create!(name: "The Shop")
      Merchant.create!(name: "The Shop at Clear Water")
      Merchant.create!(name: "The Shoppe")
      Merchant.create!(name: "The Shoppe at Clear Water ")
      get("/api/v1/merchants/#{m1.id}")

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchant.count).to eq(1)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:attributes]).to have_key(:name)
    end
  end
end