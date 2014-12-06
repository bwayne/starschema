class GenerateOrderData < ActiveRecord::Migration
	def change
		
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
end
