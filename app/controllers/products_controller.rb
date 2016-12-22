class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find( params[:id] )
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
      flash.now[:alert] = "新商品添加失败"
      render "new"
    end
  end

  def edit
    @product = Product.find( params[:id] )
  end

  def update
    @product = Product.find( params[:id] )

    if @product.update( product_params )
      flash[:notice] = "商品修改成功"
      redirect_to @product
    else
      flash.now[:alert] = "商品修改失败"
      render "edit"
    end
  end

  private

    def product_params
      params.require(:product).permit(:name, :price)
    end
end
