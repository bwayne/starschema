class AddJcrewData < ActiveRecord::Migration
  def change
	x = 0
	products_only = []
	variations = []
	
	def getData(jsonURL, hash, catNum)
		jsonfile = File.read(jsonURL)
		newHash = JSON.parse(jsonfile)
		allItems = newHash["results"][hash]
		allItems.each { |i|
			separated = i.name.rpartition(" in ")
			products_only[x] = separated[0]
			variations[x] = separated[2]
			x += 1
			newProduct = Product.new
			newProduct.product_category_id = catNum
			newProduct.name = i["item_name"]["text"]
			newProduct.price = i["price"]
			newProduct.sale_price = i["sale_price"]
			newProduct.save
		}
	end
	
	getData('app/assets/javascripts/women-sweaters.json', 'women_all_sweaters', 5)
	getData('app/assets/javascripts/women-knitstees.json', 'women_all_knitstees', 6)
	getData('app/assets/javascripts/women-shirtstops.json', 'women_all_shirtstops', 7)
	# 8 is Denim -- skipped because page structre made API difficult
	getData('app/assets/javascripts/women-pants.json', 'women_all_pants', 9)
	getData('app/assets/javascripts/women-outerwear.json', 'women_all_outerwear', 10)
	getData('app/assets/javascripts/women-blazers.json', 'women_all_blazers', 11)
	getData('app/assets/javascripts/women-dresses.json', 'women_all_dresses', 12)
	getData('app/assets/javascripts/women-skirts.json', 'women_all_skirts', 13)
	getData('app/assets/javascripts/women-shorts.json', 'women_all_shorts', 14)
	getData('app/assets/javascripts/men-casualshirts.json', 'men_all_casualshirts', 29)
  end
end



