class AddProductOrderCounter < ActiveRecord::Migration
  def up
	  add_column :products, :order_items_count, :integer, default: 0, null: false
	  
	  Product.all.each do |i|
		  Product.reset_counters(i.id, :order_items)
	  end
  end
  
  def down 
	  remove_column :products, :order_item_count
  end
  
end
