require "rails_helper"

RSpec.feature "用户可以去结算" do
  let!(:television) { FactoryGirl.create(:product, name: "电视机", price: 1500) }
  let!(:fridge) { FactoryGirl.create(:product, name: "电冰箱", price: 800) }
  let(:user) { FactoryGirl.create(:user) }
  let!(:cart1) { FactoryGirl.create(:cart, amount: 2, user: user, product: television) }
  let!(:cart2) { FactoryGirl.create(:cart, amount: 3, user: user, product: fridge) }
  let!(:address) { FactoryGirl.create(:address, name: "张三", addr: "黑龙江哈尔滨", user: user) }

  before do
    sign_in(user)
    
    visit "/"
    click_link "购物车"
    click_button "去结算"
  end

  scenario "如果正确填写个人信息" do
    fill_in "收货人姓名", with: "张三"
    fill_in "地址", with: "黑龙江哈尔滨"

    click_button "创建新地址"

    choose('货到付款')
    choose('邮局包裹')

    click_button "提交"

    # expect(page).to have_content "电视机"
    # expect(page).to have_content "数量:2"
    # expect(page).to have_content "电冰箱"
    # expect(page).to have_content "数量:3"

    expect(page).to have_content "张三"
    expect(page).to have_content "黑龙江哈尔滨"
    expect(page).to have_content "货到付款"
    expect(page).to have_content "邮局包裹"
    
    click_button "提交订单"

    expect(page).to have_content "订单提交成功"

    click_link "付款"

    expect(page).to have_content "付款成功"
  end

  scenario "如果已经有了可用的地址可以直接选择这个可用地址" do
    click_link "使用这个地址"

    choose('货到付款')
    choose('邮局包裹')

    click_button "提交"

    # expect(page).to have_content "电视机"
    # expect(page).to have_content "数量:2"
    # expect(page).to have_content "电冰箱"
    # expect(page).to have_content "数量:3"

    expect(page).to have_content "张三"
    expect(page).to have_content "黑龙江哈尔滨"
    expect(page).to have_content "货到付款"
    expect(page).to have_content "邮局包裹"
    
    click_button "提交订单"

    expect(page).to have_content "订单提交成功"

    # click_link "付款"

    # expect(page).to have_content "付款成功"
  end
end
