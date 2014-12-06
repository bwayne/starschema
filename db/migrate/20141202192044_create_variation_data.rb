class CreateVariationData < ActiveRecord::Migration
  def change
	Product.where("name LIKE '% in %'").each do |i|
			separated = i.name.rpartition(" in ")
			parent = Product.find_by name: separated[0]
			newVariation = parent.product_variations.create
			newVariation.name = separated[2]
			newVariation.save
	end
  end
end