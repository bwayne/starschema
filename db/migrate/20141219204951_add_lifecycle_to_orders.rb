class AddLifecycleToOrders < ActiveRecord::Migration
	def up
		Customer.includes(:orders).where("total_purchases > ?", 0).each do |i|
			orders = i.orders.all
			first = orders[0]
			first.lifecycle_stage_id = 2
			first.save
			if orders.count > 1
				second = orders[1]
				second.lifecycle_stage_id = 3
				second.save
			end
			if orders.count > 2
				third = orders[2]
				third.lifecycle_stage_id = 3
				third.save
			end
			
			orders.each { |i| i.lifecycle_stage_id ||= 4; i.save }
		end
	
	end
	def down
		Order.all.each { |i| i.lifecycle_stage_id = nil; i.save }
	end
end


