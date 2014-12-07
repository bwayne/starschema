class PerformanceController < ApplicationController
  def index
	  @customers = Customer.all
	  @orders = Order.all
	  @order_items = OrderItem.all
	  @products = Product.all.order("order_items_count DESC")
	  @product_categories = ProductCategory.all.order("order_items_count DESC")
  end
end
