class Order < ActiveRecord::Base
	belongs_to :customer
	belongs_to :lifecycle_stage
	has_many :order_items, dependent: :destroy
	has_many :products, through: :order_items
	has_many :product_variations, through: :order_items
	has_many :product_categories, through: :order_items
	has_many :brands, through: :order_items

# 	after_create :increment_Lifecycle_counter_cache
	
	
# 	def increment_Lifecycle_counter_cache
# 		LifecycleStage.increment_counter( "customer_count", self.lifecycle_stage.id)
# 	end
	
# 	def decrement_Product_Customer_counter_cache
# 		Product.decrement_counter( "customer_count", self.product.id)
# 	end


end
