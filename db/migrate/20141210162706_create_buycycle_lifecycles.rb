class CreateBuycycleLifecycles < ActiveRecord::Migration
  def up
    create_table :buycycle_lifecycles do |t|
	  t.belongs_to :buycycle_stage
	  t.belongs_to :lifecycle_stage
	  t.integer :customer_count, default: 0, null: false

      t.timestamps
    end    

	LifecycleStage.all.each do |life|
	    BuycycleStage.all.each do |buy|
		    newOne = BuycycleLifecycle.new
		    newOne.buycycle_stage_id = buy.id
		    newOne.lifecycle_stage_id = life.id
		    newOne.save
		end
	end
  end
  
  def down
	  drop_table :buycycle_lifecycles
  end
end
