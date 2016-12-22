require "rails_helper"

RSpec.feature "用户可以查看已有商品" do
  let!(:product) { FactoryGirl.create(:product, name: "电水壶") }
  
  scenario "带有商品的详情" do
    visit "/"

    click_link "电水壶"

    expect( page.current_url ).to eq product_url( product )
  end
end
