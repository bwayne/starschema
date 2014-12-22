class GenerateOrderData < ActiveRecord::Migration
	def up
	  add_column :product_variations, :order_items_count, :integer, default: 0, null: false
	  add_column :product_categories, :order_items_count, :integer, default: 0, null: false
	  add_column :brands, :order_items_count, :integer, default: 0, null: false
	  add_column :products, :order_items_count, :integer, default: 0, null: false
	  
	  Product.all.each do |i|
		  Product.reset_counters(i.id, :order_items)
	  end
	  
	  ProductVariation.all.each do |i|
		  ProductVariation.reset_counters(i.id, :order_items)
	  end

	  ProductCategory.all.each do |i|
		  ProductCategory.reset_counters(i.id, :order_items)
	  end

	  Brand.all.each do |i|
		  Brand.reset_counters(i.id, :order_items)
	  end
		
		customers = (Customer.all.count / 1.7).round(0)
		(1..942).each do |i|
			thisCustomer = Customer.find(i)
			orderCount = thisCustomer.total_purchases.to_i
			orderCount.times do |i|
				newOrder = thisCustomer.orders.create
				prng = Random.new
				numberOfItems = prng.rand(1..5)
				numberOfItems.times do |i|
					newOrderItem = newOrder.order_items.create
					newOrderItem.customer_id = newOrder.customer_id
					randomProduct = prng.rand(1..Product.all.count)
					newOrderItem.product_id = randomProduct
					newOrderItem.product_category_id = Product.find(randomProduct).product_category_id
					if Product.find(randomProduct).sale_price != nil then
						newOrderItem.item_price = Product.find(randomProduct).sale_price
					else
						newOrderItem.item_price = Product.find(randomProduct).price 
					end
					newOrderItem.item_quantity = 1
					newOrderItem.item_subtotal = newOrderItem.item_price
					newOrderItem.save
				end
				newOrder.order_total = newOrder.order_items.sum("item_subtotal")
				newOrder.save
			end
			
		end
	end
	
	def down 
	  remove_column :product_variations, :order_item_count
	  remove_column :product_categories, :order_item_count
	  remove_column :brands, :order_item_count
	  remove_column :products, :order_item_count
	end
end
