class CustomerDiscoveryController < ApplicationController
	
  def index
	  @customers = Customer.all
	  @orders = Order.all
	  @order_items = OrderItem.all
	  @products = Product.all.order("order_items_count DESC")
	  @product_categories = ProductCategory.all.order("order_items_count DESC")
	  @noPurchase = Customer.where("lifecycle_stage_id = ?", 1).count
	  @onePurchase = Customer.where("lifecycle_stage_id = ?", 2).count
	  @repeat = Customer.where("lifecycle_stage_id = ?", 3).count
	  @loyal = Customer.where("lifecycle_stage_id = ?", 4).count
	  
	  # auto-vivifying hash -- http://stackoverflow.com/questions/10253105/dynamically-creating-a-multi-dimensional-hash-in-ruby
# 	  @buycycle_data = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) }
# 	  @buycycle_data = Hash.new {|h,k| h[k] = []}
		
		radius = NormalDistribution.new(5000, 3000)
		productRadius = NormalDistribution.new(3000,1000)
		xAxis = NormalDistribution.new(10,4)
		
		
		@buycycle_data = []
		@device_data = []
		@product_data = []
		@largest_dimension = 0
		@goal_affinity = [{
			"name" => "Demographics",
			"id" => "Demographics",
			"children" => [{
				"name" => "Age",
				"id" => "age",
				"children" => [
					{"name" => "18-24", "size" => 0, "affinity" => 0},
					{"name" => "25-34", "size" => 0, "affinity" => 0},
					{"name" => "35-44", "size" => 0, "affinity" => 0},
					{"name" => "45-54", "size" => 0, "affinity" => 0},
					{"name" => "55-64", "size" => 0, "affinity" => 0},
					{"name" => "65+", "size" => 0, "affinity" => 0}
				]
			},{
				"name" => "Gender",
				"id" => "Gender",
				"children" => [
					{"name" => "Female", "size" => 0, "affinity" => 0},
					{"name" => "Male", "size" => 0, "affinity" => 0}
				]	
			},{
				"name" => "Income",
				"id" => "Income",
				"children" => [
					{"name" => ">$25k", "size" => 0, "affinity" => 0},
					{"name" => "$25k-$50k", "size" => 0, "affinity" => 0},
					{"name" => "$50k-$100k", "size" => 0, "affinity" => 0},
					{"name" => "$100k-$150k", "size" => 0, "affinity" => 0},
					{"name" => "$150k-$200k", "size" => 0, "affinity" => 0},
					{"name" => "$200k+", "size" => 0, "affinity" => 0}
				]
			},{
				"name" => "Country",
				"id" => "Country",
				"children" => []
			},{
				"name" => "State/Province",
				"id" => "State_Province",
				"children" => []
			},{
				"name" => "City",
				"id" => "City",
				"children" => []				
			}]
		},{
			"name" => "Sources",
			"id" => "Sources",
			"children" => [{
				"name" => "Medium",
				"id" => "Medium",
				"children" => [
					{"name" => "Direct", "size" => 0, "affinity" => 0},
					{"name" => "Referral", "size" => 0, "affinity" => 0},
					{"name" => "Search Engine", "size" => 0, "affinity" => 0},
					{"name" => "Email", "size" => 0, "affinity" => 0},
					{"name" => "Ad View", "size" => 0, "affinity" => 0}
				]
			},{
				"name" => "Campaign",
				"id" => "Campaign",
				"children" => [
					{"name" => "Lorem", "size" => 0, "affinity" => 0},
					{"name" => "Ipsum", "size" => 0, "affinity" => 0},
					{"name" => "Dolor", "size" => 0, "affinity" => 0},
					{"name" => "Sit", "size" => 0, "affinity" => 0},
					{"name" => "Amet", "size" => 0, "affinity" => 0},
					{"name" => "Adipiscing", "size" => 0, "affinity" => 0}
				]
			},{
				"name" => "Keyword",
				"id" => "Keyword",
				"children" => [
					{"name" => "Lorem", "size" => 0, "affinity" => 0},
					{"name" => "Ipsum", "size" => 0, "affinity" => 0},
					{"name" => "Dolor", "size" => 0, "affinity" => 0},
					{"name" => "Sit", "size" => 0, "affinity" => 0},
					{"name" => "Amet", "size" => 0, "affinity" => 0},
					{"name" => "Adipiscing", "size" => 0, "affinity" => 0}
				]
				
			}]
		},{
# 			"name" => "Visit Behavior",
# 			"id" => "Visit_Behavior",
# 			"children" => [{
# 				"name" => "Last Seen",
# 				"id" => "Last_Seen",
# 				"children" => []
# 			},{
# 				"name" => "Date of First Session (cohort)",
# 				"id" => "first_session",
# 				"children" => []				
# 			},{
# 				"name" => "Number of Visits",
# 				"id" => "number_of_visits",
# 				"children" => []				
# 			},{
# 				"name" => "Cart Abandonment Rate",
# 				"id" => "cart_abandonment",
# 				"children" => []				
# 			},{
# 				"name" => "Lifecycle",
# 				"id" => "Lifecycle",				
# 				"children" => [
# 					{"name" => "No Purchase", "size" => 0, "affinity" => 0},
# 					{"name" => "1 Purchase", "size" => 0, "affinity" => 0},
# 					{"name" => "Repeat", "size" => 0, "affinity" => 0},
# 					{"name" => "Loyal", "size" => 0, "affinity" => 0}
# 				]
# 			},{
# 				"name" => "Buying Cycle",
# 				"id" => "Buying_Cycle",
# 				"children" => [
# 					{"name" => "At Risk", "size" => 0, "affinity" => 0},
# 					{"name" => "Recent Buyers", "size" => 0, "affinity" => 0},
# 					{"name" => "Awareness", "size" => 0, "affinity" => 0},
# 					{"name" => "Interest", "size" => 0, "affinity" => 0},
# 					{"name" => "Considering", "size" => 0, "affinity" => 0},
# 					{"name" => "Intent", "size" => 0, "affinity" => 0}
# 				]
# 			},{
# 				"name" => "Time Since Last Purchase",
# 				"id" => "time_since_last_purchase",
# 				"children" => []				
# 			},{
# 				"name" => "Average Order Value",
# 				"id" => "aov",
# 				"children" => []				
# 				
# 			}]
# 		},{
			"name" => "Product Behavior",
			"id" => "product_behavior",
			"children" => [{
				"name" => "Products Viewed",
				"id" => "Products_Viewed",
				"children" => []				
			},{
				"name" => "Products Purchased",
				"id" => "Products_Purchased",
				"children" => []				
			},{
				"name" => "Products Searched",
				"id" => "Products_Searched",
				"children" => []				
			},{
				"name" => "Products Added to Cart",
				"id" => "Products_Added_to_Cart",
				"children" => []				
			}]
		},{
			"name" => "Category Behavior",
			"id" => "Category_Behavior",
			"children" => [{
				"name" => "Categories Viewed",
				"id" => "Categories_Viewed",
				"children" => []				
			},{
				"name" => "Categories Purchased",
				"id" => "Categories_Purchased",
				"children" => []				
			},{
				"name" => "Categories Searched",
				"id" => "Categories_Searched",
				"children" => []				
			},{
				"name" => "Categories Added to Cart",
				"id" => "Categories_Added_to_Cart",
				"children" => []				
			}]
		},{
			"name" => "Technographics",
			"id" => "Technographics",
			"children" => [{
				"name" => "Browser",
				"id" => "Browser",
				"children" => [
					{"name" => "Chrome", "size" => 0, "affinity" => 0},
					{"name" => "Mozilla", "size" => 0, "affinity" => 0},					
					{"name" => "Internet Explorer", "size" => 0, "affinity" => 0},
					{"name" => "Safari", "size" => 0, "affinity" => 0},
					{"name" => "Other", "size" => 0, "affinity" => 0}
				]
			},{
				"name" => "OS",
				"id" => "OS",				
				"children" => [
					{"name" => "iOS", "size" => 0, "affinity" => 0},
					{"name" => "Android", "size" => 0, "affinity" => 0},
					{"name" => "Blackberry", "size" => 0, "affinity" => 0},
					{"name" => "Windows Mobile", "size" => 0, "affinity" => 0},
					{"name" => "Windows", "size" => 0, "affinity" => 0},
					{"name" => "Mac", "size" => 0, "affinity" => 0},
					{"name" => "Linux", "size" => 0, "affinity" => 0}
				]
			},{
				"name" => "Mobile",
				"id" => "Mobile",
				"children" => [
					{"name" => "Has Used Mobile", "size" => 0, "affinity" => 0},
					{"name" => "Has Not Used Mobile", "size" => 0, "affinity" => 0}
				]
			},{
				"name" => "Device Type",
				"id" => "Device_Type",
				"children" => [
					{"name" => "Computer", "size" => 0, "affinity" => 0},
					{"name" => "Phone", "size" => 0, "affinity" => 0},
					{"name" => "Tablet", "size" => 0, "affinity" => 0}
				]
			},{
				"name" => "Model",
				"id" => "Model",
				"children" => [
					{"name" => "iPhone 4", "size" => 0, "affinity" => 0},
					{"name" => "iPhone 5", "size" => 0, "affinity" => 0},
					{"name" => "iPhone 6", "size" => 0, "affinity" => 0},
					{"name" => "iPhone 6 Plus", "size" => 0, "affinity" => 0},
					{"name" => "Samsung Galaxy", "size" => 0, "affinity" => 0},
					{"name" => "Motorola", "size" => 0, "affinity" => 0},
					{"name" => "Blackberry", "size" => 0, "affinity" => 0},
					{"name" => "Other", "size" => 0, "affinity" => 0}
				]
			}]
		}]
		
		def getNumber(d, num, val, round)
			newNum = num.rng.round(round)
			until newNum > 0 
				newNum = num.rng.round(round)
			end
			d[val] = newNum
		end

		@goal_affinity.each do |group|
			group["children"].each do |dimension|
				if dimension["name"] =~ /Products/
					Product.all.each do |i|
						size = productRadius.rng.round(0)
						until size > 0
							size = productRadius.rng.round(0)
						end
						affinity = xAxis.rng.round(5)
						until affinity > 0
							affinity = xAxis.rng.round(5)
						end
						dimension["children"] << {
							"name" => i.name, 
# 							"id" => i.name.to_s,
							"size" => size,
							"affinity" => affinity
						}
					end
					dimension["children"].each do |i|
# 						i["id"].sub! " ", "_"
					end
				else
					dimension["children"].each do |attribute|
						getNumber(attribute, radius, "size", 0)
						getNumber(attribute, xAxis, "affinity", 5)
#						attribute["id"] = attribute["name"]
#						attribute["id"].gsub! " ", "_"
					end
				end
			end
		end

		
# 		@goal_affinity.each do |k1, v1|
# 			twoLevels = []
# 			threeLevels = []
# 			fourLevels = []
# 			puts "#{k1} = #{v1}"
# 			v1.each do |k2, v2|
# 				puts "	#{k2} = #{v2}"
# 				v2.each do |k3, v3|
# 					puts "		#{k3} = #{v3}"
# 					if v3 != {}
# 						v3.each do |k4, v4|
# 							v4 = {
# 								"size" => prng.rand(5000),
# 								"affinity" => prng.rand(-5.0..5.0)
# 							}
# 							puts "			k4 = #{k4}"
# 							v4.each do |k5, v5|
# 								puts "				#{k5} = #{v5}"
# 							end
# 						end
# 					elsif k3 =~ /Products/
# 						Product.all.each do |product|
# 							v3[product.name] = {
# 								"size" => prng.rand(5000),
# 								"affinity" => prng.rand(-5.0..5.0)
# 							}
# 							puts "			k4 = #{product.name}"
# 							v3[product.name].each do |k5, v5|
# 								puts "				#{k5} = #{v5}"							
# 							end
# 						end
# 						
# 					elsif k3 =~ /Categories/
# 						ProductCategory.all.each do |category|
# 							v3[category.name] = {
# 								"size" => prng.rand(5000),
# 								"affinity" => prng.rand(-5.0..5.0)
# 							}
# 							puts "			k4 = #{category.name}"
# 							v3[category.name].each do |k5, v5|
# 								puts "				#{k5} = #{v5}"							
# 							end
# 						end
# 					elsif k3 == "Country"
# 						Country.all.each do |country|
# 							v3[country.name] = {
# 								"size" => country.customer_count,
# 								"affinity" => prng.rand(-5.0..5.0)
# 							}
# 							puts "			k4 = #{country.name}"
# 							v3[country.name].each do |k5, v5|
# 								puts "				#{k5} = #{v5}"							
# 							end
# 						end
# 					elsif k3 =~ /State/
# 						State.all.each do |state|
# 							v3[state.name] = {
# 								"size" => state.customer_count,
# 								"affinity" => prng.rand(-5.0..5.0)
# 							}
# 							puts "			k4 = #{state.name}"
# 							v3[state.name].each do |k5, v5|
# 								puts "				#{k5} = #{v5}"							
# 							end
# 						end
# 					elsif k3 == "City"
# 						City.all.each do |city|
# 							v3[city.name] = {
# 								"size" => city.customer_count,
# 								"affinity" => prng.rand(-5.0..5.0)
# 							}
# 							puts "			k4 = #{city.name}"
# 							v3[city.name].each do |k5, v5|
# 								puts "				#{k5} = #{v5}"							
# 							end
# 						end
# 					else 
# 						twoLevels << "#{k2} -> #{k3}"
# 					end
# 					
# 				end
# 			end
# 			puts "2 levels deep:"
# 			twoLevels.each {|i| puts "	- #{i}"}
# 			puts "3 levels deep:"
# 			threeLevels.each { |i| puts "	- #{i}" }
# 		end
				
		gon.goal_affinity = @goal_affinity.to_json
# 	  gon.buycycle_data = @buycycle_data.to_json

  end
end
