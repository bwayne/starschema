class AddLifecycleDataToCustomers < ActiveRecord::Migration
	def up
		# currently there are 949 customers with more than 10 orders, need to cut that down by 3/4
# 		too_many = Customer.where("total_purchases > ?", 10)
# 		
# 		count = 0
# 		too_many.each do |i|
# 			count += 1
# 			if count % 4 != 0
# 				i.total_purchases = 0
# 				i.orders.delete_all
# 				i.lifecycle_stage_id = 1
# 				i.save
# 			end
# 		end
# 		
		
		
		Customer.all.each do |i|
			if i.total_purchases == 0
				i.lifecycle_stage_id = 1
				LifecycleStage.increment_counter( "customer_count", 1)
			
			elsif i.total_purchases == 1
				i.lifecycle_stage_id = 2
				LifecycleStage.increment_counter( "customer_count", 2)

			elsif i.total_purchases == 2 || i.total_purchases == 3
				i.lifecycle_stage_id = 3
				LifecycleStage.increment_counter( "customer_count", 3)

			else
				i.lifecycle_stage_id = 4
				LifecycleStage.increment_counter( "customer_count", 4)

			end
			i.save
		end
	end

	def down
		Customer.all.each do |i|
			i.lifecycle_stage_id = nil
		end
	end
end
