class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new( product_params )

    if @product.save
      flash[:notice] = "新商品添加成功"
      redirect_to @product
    else
      # nothing, yet
    end
  end

  def show
    @product = Product.find( params[:id] )
  end

  private

    def product_params
      params.require(:product).permit(:name, :price)
    end
end
