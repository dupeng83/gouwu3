class StoreController < ApplicationController
  def index
    @products = Product.all
  end

  def detail
    @product = Product.find( params[:id] )
    @cart = @product.carts.build
  end

  def create_cart
    authenticate_user!

    product = Product.find( params[:cart][:product_id] )
    cart = product.carts.build( cart_params )

    # 将当前的购物车cart的所有者设置为current_user
    cart.user = current_user

    item_in_cart = product.carts.where(user_id: cart.user_id).take

    if item_in_cart.nil?
      cart_to_save = cart
    else
      item_in_cart[:amount] += cart.amount
      cart_to_save = item_in_cart
    end 

    if cart_to_save.save
      redirect_to show_cart_path
    else
      alert = "Adding to Cart Failed"
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
