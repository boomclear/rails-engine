require 'rails_helper'

RSpec.describe "item create" do
  describe "item post API Request", :vcr do
    it 'post new item in json-api compliance' do
      m1 = Merchant.create!(name: "The Shop")
      item_params = ({
        name: "Item 20",
        description: "Lorem Ipsum",z
        unit_price: 99.99,
        merchant_id: m1.id
      })
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/items", headers: headers, params: JSON.generate(item_params)

      created_item = Item.last
      expect(response).to be_successful
     
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
    end
  end
end