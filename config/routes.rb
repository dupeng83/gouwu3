Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'
    
    resources :products
    resources :users
  end

  devise_for :users

  root "store#index"

  #首页上显示商品列表的路由
  get '/prod/:id', to: 'store#detail', as: 'pd'

  #商品页面填入购买数量后处理表单的路由
  post '/create_cart', to: 'store#create_cart'

  #显示购物车的路由
  get '/show_cart', to: 'store#show_cart'

  #提交购物车表单(去结算)的路由
  patch '/cart_submit', to: 'store#create_order_item'
end
