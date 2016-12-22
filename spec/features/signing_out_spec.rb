require "rails_helper"

RSpec.feature "Signed-in users can sign out" do
  let!(:user) { FactoryGirl.create(:user) }

  before do
    sign_in(user)
  end

  scenario do
    visit "/"
    click_link "退出"
    expect(page).to have_content "Signed out successfully."
  end
end
