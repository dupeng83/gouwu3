require "rails_helper"

RSpec.feature "用户可以修改已有商品" do
  let(:user) { FactoryGirl.create(:user, :admin) }
  let!(:product) { FactoryGirl.create(:product, name: "电水壶", price: 100) }
  
  before do
    sign_in(user)
    visit admin_root_path

    click_link "商品管理"
    click_link "电水壶"

    click_link "修改"
  end
  
  scenario "如果正确填写商品参数" do
    fill_in "商品名", with: "新型电水壶"
    fill_in "价格", with: 150
    click_button "添加"

    expect(page).to have_content "商品修改成功"
    expect(page).to have_content "新型电水壶"
  end

  scenario "如果没有正确填写商品参数" do
    fill_in "商品名", with: ""
    fill_in "价格", with: "一百"
    click_button "添加"

    expect(page).to have_content "商品修改失败"
  end
end
