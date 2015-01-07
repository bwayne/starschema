class FixDuplicateCities < ActiveRecord::Migration
  def change
	  City.all.each do |i|
		  customerCount = Customer.where("city = ? AND state_id = ?", i.name, i.state_id).count
		  dupes = City.where("name = ? AND state_id = ?", i.name, i.state_id)
		  count = dupes.count
		  if count > 1
			  dupesToDelete = dupes.limit(count - 1)
			  dupesToDelete.destroy_all
		  end	  
	  end
  end
end
