class OrderItem < ActiveRecord::Base
	belongs_to :customer
	belongs_to :order
	belongs_to :product
	belongs_to :product_variation
	belongs_to :product_category
	belongs_to :brand	
end
