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
    
    # # 将当前的购物车cart的所有者设置为current_user
    # cart.user = current_user

    # product = Product.find( params[:cart][:product_id] )
    # cart = product.carts.build( cart_params )

    # item_in_cart = product.carts.where(user_id: cart.user_id).take

    # if item_in_cart.nil?
    #   cart_to_save = cart
    # else
    #   item_in_cart[:amount] += cart.amount
    #   cart_to_save = item_in_cart
    # end 

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

  private

    def cart_params
      params.require(:cart).permit(:amount)
    end
end
