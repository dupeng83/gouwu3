require "rails_helper"

RSpec.feature "用户可以添加新商品" do
  let(:admin) { FactoryGirl.create(:user, :admin) }

  before do
    sign_in(admin)
    visit admin_root_path

    click_link "商品管理"
    click_link "添加新商品"
  end
  
  scenario "如果正确填写商品参数" do
    fill_in "商品名", with: "电水壶"
    fill_in "价格", with: "100"
    click_button "添加"

    expect(page).to have_content "新商品添加成功"
  end

  scenario "如果没有正确填写商品参数" do
    click_button "添加"

    expect(page).to have_content "新商品添加失败"
  end

  scenario "如果价格栏没有填写数字" do
    fill_in "商品名", with: "电水壶"
    fill_in "价格", with: "一百"
    click_button "添加"

    expect(page).to have_content "新商品添加失败"
  end

  scenario "如果价格栏留空" do
    fill_in "商品名", with: "电水壶"
    click_button "添加"

    expect(page).to have_content "新商品添加失败"
  end
end
