require "rails_helper"

RSpec.feature "管理员可以改动用户信息" do
  let(:admin_user) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(admin_user)
    visit admin_user_path(user)
    click_link "编辑用户"
  end

  scenario "如果数据合法" do
    fill_in "Email", with: "newguy@example.com"
    click_button "创建用户"

    expect(page).to have_content "用户修改成功"
    expect(page).to have_content "newguy@example.com"
    expect(page).to_not have_content user.email
  end

  scenario "可将普通用户改成管理员" do
    check "设置为管理员"
    click_button "创建用户"

    expect(page).to have_content "用户修改成功"
    expect(page).to have_content "#{user.email} (Admin)"
  end
end
