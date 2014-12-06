class Order < ActiveRecord::Base
	belongs_to :customer
	has_many :order_items
	has_many :products, through: :order_items
	has_many :product_variations, through: :order_items
	has_many :product_categories, through: :order_items
	has_many :brands, through: :order_items
end
