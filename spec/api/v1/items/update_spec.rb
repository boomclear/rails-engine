require 'rails_helper'

RSpec.describe "item update" do
  describe "item post API Request", :vcr do
    it 'post new item in json-api compliance' do
      m1 = Merchant.create!(name: "The Shop")
      i1 = Item.create!(name: "Item 15", description: "Lorem Ipsum", unit_price: 34.00, merchant_id: m1.id)
      item_params = ({
        name: "Item 21",
        description: "Lorem Ipsum",
        unit_price: 99.99,
        merchant_id: m1.id
      })
      headers = {"CONTENT_TYPE" => "application/json"}
      put "/api/v1/items/#{i1.id}", headers: headers, params: JSON.generate(item_params)

      updated_item = Item.last
      expect(response).to be_successful
     
      expect(updated_item.name).to eq(item_params[:name])
      expect(updated_item.description).to eq(item_params[:description])
      expect(updated_item.unit_price).to eq(item_params[:unit_price])
      expect(updated_item.merchant_id).to eq(item_params[:merchant_id])
    end
  end
end