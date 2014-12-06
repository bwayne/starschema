class Product < ActiveRecord::Base
	belongs_to :product_category
	belongs_to :brand
	has_many :order_items
	has_many :product_variations
	has_many :customers, through: :order_items
	has_many :orders, through: :order_items
end
