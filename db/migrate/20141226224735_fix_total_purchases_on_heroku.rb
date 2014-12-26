class FixTotalPurchasesOnHeroku < ActiveRecord::Migration
  def change
	  Customer.includes(:orders).all.each do |i|
		  tp = i.orders.all.count
		  i.total_purchases = tp
		  i.save
	  end
  end
end
