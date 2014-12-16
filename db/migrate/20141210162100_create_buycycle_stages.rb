class CreateBuycycleStages < ActiveRecord::Migration
  def up
    create_table :buycycle_stages do |t|
		t.string :name
	    t.integer :customer_count, default: 0, null: false
      t.timestamps
    end        
  end
  
  def down
	  drop_table :buycycle_stages
  end
end
