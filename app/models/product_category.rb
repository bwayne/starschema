class ProductCategory < ActiveRecord::Base
	has_many :products
	has_many :order_items
	has_many :customers, through: :order_items
	has_many :orders, through: :order_items
	has_many :brands, through: :products
	has_many :product_variations, through: :products
	has_many :children, class_name: "ProductCategory"
	belongs_to :parent, class_name: "ProductCategory", foreign_key: "parent_id"

	def self.order_count
		order_items.count
	end

end
