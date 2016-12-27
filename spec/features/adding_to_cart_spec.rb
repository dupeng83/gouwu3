require "rails_helper"

RSpec.feature "用户可以将商品添加到购物车" do
  let!(:television) { FactoryGirl.create(:product, name: "电视机", price: 1500) }
  let!(:fridge) { FactoryGirl.create(:product, name: "电冰箱", price: 800) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in(user)
    
    visit "/"
    click_link "电视机"

    fill_in "数量", with: 2
    click_button "加入购物车"

    visit "/"
  end

  scenario "如果正确填写商品数量" do
    click_link "电冰箱"

    fill_in "数量", with: 3
    click_button "加入购物车"

    within("table") do
      expect(page).to have_content "电视机"
      expect(page).to have_content "电冰箱"
    end

    # within("form input") do
    #   expect(page).to have_content "2"
    #   expect(page).to have_content "3"
    # end

    within("td#total_price") do
      expect(page).to have_content "5400"
    end
    # expect(page).to have_content 5 * product.price
  end

  scenario "如果同一样商品购买了两次" do
    click_link "电视机"

    fill_in "数量", with: 3
    click_button "加入购物车"

    within("table") do
      expect(page).to have_content "电视机"
    end

    # within("form .num-input") do
    #   expect(page).to have_content 5
    # end

    within("td#total_price") do
      expect(page).to have_content "7500"
    end
  end
end
