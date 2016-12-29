class StoreController < ApplicationController
  # 显示主页,获取所有商品,送主页显示
  def index
    @products = Product.all
  end

  def detail
    @product = Product.find( params[:id] )
    @cart = @product.carts.build
  end

  def create_cart
    authenticate_user!

    #用户要购买的商品的id
    product_id = params[:cart][:product_id]

    #如果该商品已经在购物车中了,又增加了购买数量
    if current_user.carts.exists?(product_id: product_id)
      cart_to_save = current_user.carts.find_by(product_id: product_id)
      cart_to_save.amount += params[:cart][:amount].to_i
    #否则该商品就是第一次购买
    else
      cart_to_save = current_user.carts.build(cart_params)
      cart_to_save.product_id = product_id
    end

    if cart_to_save.save
      redirect_to show_cart_path
    else
      alert = "加入购物车失败"
      redirect_to root_path
    end
  end

  def show_cart
    @total_price = 0
    current_user.carts.each do |cart_item|
      @total_price += cart_item.product.price * cart_item.amount
    end
  end

  # 把购物车提交页面提交的数据保存起来,然后重定向到地址选择页面
  # create_order_item
  def update_cart
    params[:user][:cart].each do |id, amount_value|
      cart_item = Cart.find(id)
      cart_item.amount = amount_value[:amount]

      cart_item.save
    end
    
    #重定向到地址选择页面
    redirect_to addresses_path
  end

  # 显示已有的地址,以及创建新地址的表单
  # Order#new
  def show_addresses
    @addresses = current_user.addresses
    @address = current_user.addresses.build
  end

  # 创建新的地址
  def create_address
    @address = current_user.addresses.build(address_params)

    if @address.save
      flash[:notice] = "新地址已经保存"
      # session[:address_params] = address_params
      session[:address_id] = @address.id
      redirect_to new_pay_deliver_path
    else
      flash.now[:alert] = "新地址保存失败"
      render "show_addresses"
    end
  end

  def set_address
    session[:address_id] = params[:id]
    redirect_to new_pay_deliver_path
  end

  #new2
  #显示配送和付款方式选项
  def new_pay_deliver
  end

  #创建配送和付款的方式(存入session)
  #OrdersController#update
  def create_pay_deliver
    session[:pay] = params[:pay]
    session[:deliver] = params[:deliver]

    redirect_to show_order_path
  end

  #显示订单总结页面,点提交就生成订单
  #also OrdersController#update
  def show_order
    @address = Address.find( session[:address_id] )
  end

  #生成订单
  #also OrdersController#update
  def create_order
    total_price = 0

    #建立一个新的订单(order)
    order = current_user.orders.build

    #把当前用户所有的购物车项目都在这个新订单(order)下面建立对应的order_item关联项
    current_user.carts.each do |cart|
      order_item = order.orderitems.build
      order_item.product_id = cart.product_id
      order_item.amount = cart.amount

      total_price += order_item.product.price * order_item.amount
    end

    #清除原来的购物车里的内容
    current_user.carts.clear

    #新订单的各项参数
    order.total_price = total_price
    
    order.address_id = session[:address_id]

    case session[:pay]
     when "daofu"
       order.pay_method = "货到付款"
     when "zhongyin"
       order.pay_method = "中国银行"
     end

    case session[:deliver]
     when "kuaidi"
       order.deliver_method = "快递"
     when "youju"
       order.deliver_method = "邮局包裹"
     end

    if order.save
      flash[:notice] = "订单提交成功"

      session[:address_id] = nil
      session[:pay] = nil
      session[:deliver] = nil

      session[:current_order_id] = order.id

      redirect_to new_pay_path
    else
      flash[:alert] = "订单创建失败"
      redirect_to show_order_path
    end
  end

  def new_pay
  end

  #处理交款
  #bank
  def create_pay
    if Order.find( params[:id] ).update(paid: true)
      flash[:notice] = "付款成功"
      redirect_to orders_path
    else
      flash[:alert] = "付款失败"
      redirect_to orders_path
    end
  end

  private

    def cart_params
      params.require(:cart).permit(:amount)
    end

    def address_params
      params.require(:address).permit(:name, :addr, :default)
    end
end
