class FixCityCustomerCounts < ActiveRecord::Migration
  def change
	  City.all.each do |i|
		  count = Customer.where("city = ? AND state_id = ?", i.name, i.state_id).count
		  i.customer_count = count
		  i.save
	  end
  end
end
