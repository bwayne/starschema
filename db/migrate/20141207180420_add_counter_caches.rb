class AddCounterCaches < ActiveRecord::Migration
  def up
# 	  add_column :product_variations, :order_items_count, :integer, default: 0, null: false
# 	  add_column :product_categories, :order_items_count, :integer, default: 0, null: false
# 	  add_column :brands, :order_items_count, :integer, default: 0, null: false
# 	  
# 	  ProductVariation.all.each do |i|
# 		  ProductVariation.reset_counters(i.id, :order_items)
# 	  end
# 
# 	  ProductCategory.all.each do |i|
# 		  ProductCategory.reset_counters(i.id, :order_items)
# 	  end
# 
# 	  Brand.all.each do |i|
# 		  Brand.reset_counters(i.id, :order_items)
# 	  end

  end
  
  def down 
# 	  remove_column :product_variations, :order_item_count
# 	  remove_column :product_categories, :order_item_count
# 	  remove_column :brands, :order_item_count
  end
  
end
