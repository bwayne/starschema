class Customer < ActiveRecord::Base
	has_many :orders, dependent: :destroy
	has_many :order_items
	has_many :products, through: :order_items
	has_many :product_variations, through: :order_items
	has_many :product_categories, through: :order_items
	has_many :brands, through: :order_items
	belongs_to :buycycle_stage
	belongs_to :buycycle_lifecycle
	belongs_to :lifecycle_stage
end
