class LifecyclesController < ApplicationController

  # GET /lifecycles
  # GET /lifecycles.json
  def index
	  @customers = Customer.all
	  @orders = Order.all
	  @order_items = OrderItem.all
	  @products = Product.all.order("order_items_count DESC")
	  @product_categories = ProductCategory.all.order("order_items_count DESC")
	  @noPurchase = Customer.where("lifecycle_stage_id = ?", 1).count
	  @onePurchase = Customer.where("lifecycle_stage_id = ?", 2).count
	  @repeat = Customer.where("lifecycle_stage_id = ?", 3).count
	  @loyal = Customer.where("lifecycle_stage_id = ?", 4).count
	  
	  
  end

end
