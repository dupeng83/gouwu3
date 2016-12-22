require "rails_helper"

RSpec.feature "管理员可以创建新的用户" do
  let(:admin) { FactoryGirl.create(:user, :admin) }

  before do
    login_as(admin)
    visit "/"
    click_link "Admin"
    click_link "用户管理"
    click_link "新用户"
  end

  scenario "如果提供正确数据" do
    fill_in "Email", with: "newbie@example.com"
    fill_in "Password", with: "password"
    click_button "创建用户"
    expect(page).to have_content "用户创建成功"
  end

  # scenario "when the new user is an admin" do
  #   fill_in "Email", with: "admin@example.com"
  #   fill_in "Password", with: "password"
  #   check "Is an admin?"
  #   click_button "Create User"
  #   expect(page).to have_content "User has been created."
  #   expect(page).to have_content "admin@example.com (Admin)"
  # end
end
