class AddReferencesToProductCategory < ActiveRecord::Migration
  def change
	  change_table :product_categories do |t|
		  t.references :parent
		end
  end
end
