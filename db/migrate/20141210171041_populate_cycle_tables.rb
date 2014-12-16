class PopulateCycleTables < ActiveRecord::Migration
  def change
		remove_column :buycycle_lifecycles, :buycycle_stage_id_id
		remove_column :buycycle_lifecycles, :lifecycle_stage_id_id
	  	change_table :buycycle_lifecycles do |t|
		  t.belongs_to :lifecycle_stage
		  t.belongs_to :buycycle_stage
		end
	  
	  
    lifecycleStages = ["At Risk", "Recent Buyers", "Awareness", "Interest", "Considering", "Intent"]
    lifecycleStages.each do |i|
	    newLife = LifecycleStage.new
	    newLife.name = i
	    newLife.save
	end


    buycycleStages = ["At Risk", "Recent Buyers", "Awareness", "Interest", "Considering", "Intent"]
    buycycleStages.each do |i|
	    newBuy = BuycycleStage.new
	    newBuy.name = i
	    newBuy.save
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
end
