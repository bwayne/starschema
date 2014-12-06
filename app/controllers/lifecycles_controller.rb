class LifecyclesController < ApplicationController

  # GET /lifecycles
  # GET /lifecycles.json
  def index
	  @customers = Customer.all
	  @orders = Order.all
	  @order_items = OrderItem.all
	  @products = Product.all
	  @product_categories = ProductCategory.all
	  
	  counts = Product.all.sort_by
	  
# 	  @cat_order_counts = @products.sort_by(&:order_count).reverse.to_a
# 	  puts @cat_order_counts
  end

end
