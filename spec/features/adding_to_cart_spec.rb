require "rails_helper"

RSpec.feature "用户可以将商品添加到购物车" do
  let!(:television) { FactoryGirl.create(:product, name: "电视机", price: 1500) }
  let!(:fridge) { FactoryGirl.create(:product, name: "电冰箱", price: 800) }
  let(:user) { FactoryGirl.create(:user) }

  scenario "如果正确填写商品数量" do
    sign_in(user)
    
    visit "/"
    click_link "电视机"

    fill_in "数量", with: 2
    click_button "加入购物车"

    visit "/"
    click_link "电冰箱"

    fill_in "数量", with: 3
    click_button "加入购物车"

    expect(page).to have_content "电视机"
    expect(page).to have_content "电冰箱"
    # expect(page).to have_content 5 * product.price
  end
end
