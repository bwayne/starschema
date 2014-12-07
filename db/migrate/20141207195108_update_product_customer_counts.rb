class UpdateProductCustomerCounts < ActiveRecord::Migration
  def up
	  OrderItem.all.each do |i|
		 i.increment_Product_Customer_counter_cache 
	  end
  end
  
  def down
	  OrderItem.all.each do |i|
		  i.decrement_Product_Customer_counter_cache
	  end
  end
end
