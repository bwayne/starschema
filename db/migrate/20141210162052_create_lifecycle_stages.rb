class CreateLifecycleStages < ActiveRecord::Migration
  def up
    create_table :lifecycle_stages do |t|
	    t.string :name
	    t.integer :customer_count, default: 0, null: false
      t.timestamps
    end
    
    change_table :orders do |t|
	    t.belongs_to :lifecycle_stage
	end
	
	change_table :customers do |t|
		t.belongs_to :lifecycle_stage
	end
	
    lifecycleStages = ["No Purchase", "1 Purchase", "Repeat", "Loyal"]
    lifecycleStages.each do |i|
	    newLife = LifecycleStage.new
	    newLife.name = i
	    newLife.save
	end
	
	
  end
  def down
	  drop_table :lifecycle_stages
	  remove_column :orders, :lifecycle_stage_id_id
	  remove_column :customers, :lifecycle_stage_id_id
	  
  end
end
