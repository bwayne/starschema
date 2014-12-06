class ProductVariation < ActiveRecord::Base
	belongs_to :product
	has_many :order_items
	has_many :customers, through: :order_items
	has_many :orders, through: :order_items
end
