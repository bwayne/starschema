class CreateProductVariations < ActiveRecord::Migration
  def change
    create_table :product_variations do |t|
	    t.belongs_to :product
	    t.string :name

      t.timestamps
    end
  end
end
