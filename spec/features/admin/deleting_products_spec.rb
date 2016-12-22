require "rails_helper"

RSpec.feature "用户可以删除已有商品" do
  let(:user) { FactoryGirl.create(:user, :admin) }
  let!(:product) { FactoryGirl.create(:product, name: "电水壶", price: 100) }
  
  scenario "successfully" do
    sign_in(user)
    visit admin_root_path

    click_link "商品管理"
    click_link "电水壶"
    click_link "删除"

    expect(page).to have_content "商品成功删除"
    expect(page.current_url).to eq admin_products_url
    expect(page).to have_no_content "新型电水壶"
  end
end
