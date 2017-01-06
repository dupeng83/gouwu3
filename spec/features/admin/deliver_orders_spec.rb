require "rails_helper"

RSpec.feature "管理员对于已付款的订单" do
  let!(:television) { FactoryGirl.create(:product, name: "电视机", price: 1500) }
  let!(:fridge) { FactoryGirl.create(:product, name: "电冰箱", price: 800) }
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }
  # let!(:cart1) { FactoryGirl.create(:cart, amount: 2, user: user, product: television) }
  # let!(:cart2) { FactoryGirl.create(:cart, amount: 3, user: user, product: fridge) }
  let!(:address) { FactoryGirl.create(:address, name: "张三", addr: "黑龙江哈尔滨", user: user) }
  let!(:order) { FactoryGirl.create(:order, :paid, :boc, :kuaidi,
    user: user, address: address, total_price: 1500 + 800)}

  before do
    sign_in(admin)
    
    visit admin_root_path
    click_link "订单管理"
  end

  scenario "可以邮寄订单商品" do
    # within table_row("2300") do
      click_link "邮寄"
    # end

    expect(page).to have_content "邮寄成功"
  end
end