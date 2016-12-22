require "rails_helper"

RSpec.feature "用户可以查看已有商品" do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let!(:product) { FactoryGirl.create(:product, name: "电水壶") }
  
  scenario "带有商品的详情" do
    sign_in(admin)
    visit admin_root_path

    click_link "商品管理"
    click_link "电水壶"

    expect( page.current_url ).to eq admin_product_url( product )
  end
end
