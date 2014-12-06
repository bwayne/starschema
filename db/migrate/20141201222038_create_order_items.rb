class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
		t.belongs_to :customer
	    t.belongs_to :order
	    t.belongs_to :product
	    t.belongs_to :product_variation
	    t.belongs_to :product_category
	    t.belongs_to :brand
	    t.float :item_discount
	    t.float :item_price
	    t.integer :item_quantity
	    t.float :item_subtotal

      t.timestamps
    end
  end
end
