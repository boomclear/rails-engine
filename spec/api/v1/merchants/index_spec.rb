require 'rails_helper'

RSpec.describe "Merchant Index" do
  describe "Merchant index API Request", :vcr do
    it 'displays all merchants in json-api compliance' do
      Merchant.create!(name: "The Shop")
      Merchant.create!(name: "The Shop at Clear Water")
      Merchant.create!(name: "The Shoppe")
      Merchant.create!(name: "The Shoppe at Clear Water ")
      get("/api/v1/merchants")

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:attributes]).to have_key(:name)
      end
    end
  end
end