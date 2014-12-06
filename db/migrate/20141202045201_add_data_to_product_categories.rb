class AddDataToProductCategories < ActiveRecord::Migration
  def change
	jsonfile = File.read('app/assets/javascripts/product-categories.json')
	newHash = JSON.parse(jsonfile)
	
	newHash.each { |i|
		newCategory = ProductCategory.new
		newCategory.name = i["name"]
		newCategory.parent_id = i["parent"]
		newCategory.save
	}
  end
end
