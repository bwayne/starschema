class AddBuycycleData < ActiveRecord::Migration
	def up
		change_table :customers do |t|
			t.belongs_to :buycycle_stage
			t.belongs_to :buycycle_lifecycle
		end
		
		Customer.all.each do |i|
			prng = Random.new
			newBuycycle = prng.rand(1..6)
			i.buycycle_stage_id = newBuycycle
			i.buycycle_lifecycle_id = (6 * (i.lifecycle_stage_id - 1)) + i.buycycle_stage_id
			i.save
		  
		end
	end
	
	def down
		Customer.all.each do |i|
			i.buycycle_stage = nil
			i.save
		end
	end
end



