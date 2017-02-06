require "rails_helper"

RSpec.feature "用户可以查看已提交的订单" do
  let!(:television) { FactoryGirl.create(:product, name: "电视机", price: 1500) }
  let!(:fridge) { FactoryGirl.create(:product, name: "电冰箱", price: 800) }
  let!(:pencil) { FactoryGirl.create(:product, name: "铅笔", price: 3) }
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }
  let!(:address) { FactoryGirl.create(:address, name: "张三", addr: "黑龙江哈尔滨", user: user) }
  
  let!(:order) { FactoryGirl.create(:order, :paid, :boc, :kuaidi,
    user: user, address: address, total_price: 1500 * 2 + 800 * 3)}
  let!(:order2) { FactoryGirl.create(:order, :paid, :boc, :kuaidi,
    user: user, address: address, total_price: 1500 + 3 * 2)}
  
  let!(:orderitem1) { FactoryGirl.create(:orderitem, amount: 2, 
    order: order, product: television) }
  let!(:orderitem2) { FactoryGirl.create(:orderitem, amount: 3, 
    order: order, product: fridge) }

  let!(:orderitem3) { FactoryGirl.create(:orderitem, amount: 1, 
    order: order2, product: television) }
  let!(:orderitem4) { FactoryGirl.create(:orderitem, amount: 2, 
    order: order2, product: pencil) }

  before do
    sign_in(admin)
    
    visit admin_orders_path
  end

  scenario "成功" do
    total = 1500 * 2 + 800 * 3
    within list_item("#{total}") do
      click_link "详情"
    end

    expect(page).to have_content "电视机"
    expect(page).to have_content "电冰箱"
    expect(page).not_to have_content "铅笔"
  end
end