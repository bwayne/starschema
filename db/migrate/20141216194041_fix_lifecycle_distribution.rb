class FixLifecycleDistribution < ActiveRecord::Migration
  def change
	count = 0
  	Customer.where("lifecycle_stage_id = ?", 4).each do |i|
		count += 1
		if count % 2 == 0
			i.total_purchases = 1
			i.orders.each do |order|
				if order.id != i.orders.first.id
					order.delete
				end
			i.save
			end
		end
	end
  end
end
