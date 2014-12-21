class AddDeviceTypeToOrders < ActiveRecord::Migration
  def up
	  change_table :orders do |t|
		  t.string :device_type
	  end

	  counter = 0	  
	  Order.where("mobile = ?", true).each do |i|
		  counter += 1
		  if counter % 5 == 0 then 
			  i.device_type = "Tablet"
			  i.save
		  else 
		  	i.device_type = "Mobile"
		  	i.save
		  end
	  end
	  
	  Order.where("mobile = ?", false).each {|i| i.device_type = "Computer"; i.save }

  end
  
  def down
	  remove_column :orders, :device_type
  end
end
