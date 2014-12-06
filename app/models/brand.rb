class Brand < ActiveRecord::Base
	has_many :order_items
	has_many :products
	has_many :customers, through: :order_items
	has_many :orders, through: :order_items
	has_many :product_categories, through: :products
	has_many :product_variations, through: :products
end
