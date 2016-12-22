class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
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
  end

  def update
    if @product.update( product_params )
      flash[:notice] = "商品修改成功"
      redirect_to @product
    else
      flash.now[:alert] = "商品修改失败"
      render "edit"
    end
  end

  def destroy
    @product.destroy

    flash[:notice] = "商品成功删除"
    redirect_to products_path
  end

  private

    def set_product
      @product = Product.find( params[:id] )
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "该商品不存在"
      redirect_to products_path
    end

    def product_params
      params.require(:product).permit(:name, :price)
    end
end
