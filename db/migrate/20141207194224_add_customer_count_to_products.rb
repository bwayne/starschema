class AddCustomerCountToProducts < ActiveRecord::Migration
  def up
	  add_column :products, :customer_count, :integer, default: 0, null: false
  end
  
  def down
	  remove_column :products, :customer_count
	end
end
