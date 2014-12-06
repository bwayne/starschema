class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
	    t.string :name
	    t.belongs_to :product_category
	    t.belongs_to :brand
	    t.float :price
	    t.float :sale_price

      t.timestamps
    end
  end
end
