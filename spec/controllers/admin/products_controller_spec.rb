require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  let(:user) { FactoryGirl.create(:user, :admin) }

  before do
    sign_in(user)
  end

  it "正确处理不存在的商品路由" do
    get :show, params: { id: "not-here" } 
    
    expect(response).to redirect_to(admin_products_path)

    message = "该商品不存在"
    expect(flash[:alert]).to eq message
  end
end
