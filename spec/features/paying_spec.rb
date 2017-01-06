require "rails_helper"

RSpec.feature "用户可以付款" do
  let!(:television) { FactoryGirl.create(:product, name: "电视机", price: 1500) }
  let!(:fridge) { FactoryGirl.create(:product, name: "电冰箱", price: 800) }
  let(:user) { FactoryGirl.create(:user) }
  # let!(:cart1) { FactoryGirl.create(:cart, amount: 2, user: user, product: television) }
  # let!(:cart2) { FactoryGirl.create(:cart, amount: 3, user: user, product: fridge) }
  let!(:address) { FactoryGirl.create(:address, name: "张三", addr: "黑龙江哈尔滨", user: user) }
  let!(:order) { FactoryGirl.create(:order, :unpaid, :boc, :kuaidi,
    user: user, address: address, total_price: 1500 + 800)}

  before do
    sign_in(user)
    
    visit "/"
    click_link "已提交的订单"
  end

  scenario "成功" do
    # within table_row("2300") do
      click_link "付款"
    # end

    expect(page).to have_content "付款成功"
  end
end