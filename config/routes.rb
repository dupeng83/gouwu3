Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'
    
    resources :products
    resources :users
    resources :orders, only: [:index] do
      member do
        get :deliver
      end
    end
  end

  devise_for :users

  root "store#index"

  ## 下面这些单个路由应该整理一下, 放到cart, address, order几个controller中,改用resource方式路由
  #首页上显示商品列表的路由
  get '/prod/:id', to: 'store#detail', as: 'pd'

  #商品页面填入购买数量后处理表单的路由
  post '/create_cart', to: 'store#create_cart'

  #显示购物车的路由
  get '/show_cart', to: 'store#show_cart'

  #提交购物车表单(去结算)的路由
  patch '/cart_submit', to: 'store#update_cart'

  #显示地址选择页面的路由
  get '/addresses', to: 'store#show_addresses'

  #创建新地址的路由
  post '/create_address', to: 'store#create_address'

  #地址选择页面选择已有地址的路由
  get '/set_addresses/:id', to: 'store#set_address', as: 'set_address'

  #显示配送和付款方式的路由
  get '/new_pay_deliver', to: 'store#new_pay_deliver'

  #创建配送和付款的方式(存入session)
  post '/create_pay_deliver', to: 'store#create_pay_deliver'

  #显示订单总结页面,点提交就生成订单
  get '/show_order', to: 'store#show_order'

  #生成订单
  post '/create_order', to: 'store#create_order'

  #显示处理交款页面
  get "/new_pay", to: 'store#new_pay'

  #处理交款
  get "/create_pay/:id", to: 'store#create_pay', as: 'create_pay'

  resources :orders, only: [:index, :show]
end
