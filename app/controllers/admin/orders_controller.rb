class Admin::OrdersController < Admin::ApplicationController
  def index
    @orders_to_be_delivered = Order.need_to_be_delivered
    @orders_delivered = Order.delivered
  end

  def deliver
    @order = Order.find( params[:id] )
    @order.deliver!

    flash[:notice] = "邮寄成功"
    redirect_to admin_orders_path
  end
end
