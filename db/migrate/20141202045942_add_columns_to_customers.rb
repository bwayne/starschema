class AddColumnsToCustomers < ActiveRecord::Migration
  def change
	  change_table :customers do |t|
		  t.integer :total_purchases
		  t.float :revenue
		  t.float :aov
		  t.float :ltv
	  end
  end
end
