require 'rails_helper'

RSpec.describe "item update" do
  describe "item delete API Request", :vcr do
    it 'delete  in json-api compliance' do
      m1 = Merchant.create!(name: "The Shop")
      i1 = Item.create!(name: "Item 17", description: "Lorem Ipsum", unit_price: 34.00, merchant_id: m1.id)
      delete "/api/v1/items/#{i1.id}"

      expect(response).to be_successful
      last_item = Item.last
     
      expect(last_item.name).not_to eq(i1.name)
    end
  end
end