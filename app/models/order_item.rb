class OrderItem < ActiveRecord::Base
	belongs_to :customer
	belongs_to :order
	belongs_to :product, counter_cache: true
	belongs_to :product_variation, counter_cache: true
	belongs_to :product_category, counter_cache: true
	belongs_to :brand, counter_cache: true
	
# 	after_create :increment_Product_Customer_counter_cache
# 	after_destroy :decrement_Product_Customer_counter_cache
# 	
# 	
# 	def increment_Product_Customer_counter_cache
# 		Product.increment_counter( "customer_count", self.product.id)
# 	end
# 	
# 	def decrement_Product_Customer_counter_cache
# 		Product.decrement_counter( "customer_count", self.product.id)
# 	end
	
	
	
end
