require "rails_helper"

RSpec.feature "用户可以添加新商品" do
  scenario "如果正确填写商品参数" do
    visit "/"

    click_link "添加新商品"

    fill_in "商品名", with: "电水壶"
    fill_in "价格", with: "100"
    click_button "添加"

    expect(page).to have_content "新商品添加成功"
  end
end
