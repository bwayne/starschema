class LifecyclesController < ApplicationController

  # GET /lifecycles
  # GET /lifecycles.json
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
		
		
		
		@buycycle_data = []
		@device_data = []
		@product_data = []
		@largest_dimension = 0
		LifecycleStage.all.includes(:customers => :orders, :orders => :products).each do |d, i|
			# convert milliseconds to days
			t = d.conv_time
			mm, ss = t.divmod(60)            #=> [4515, 21]
			hh, mm = mm.divmod(60)           #=> [75, 15]
			dd, hh = hh.divmod(24)           #=> [3, 3]
			hours = hh / 24.0
			days = dd + hours.round(2)
 			#time_converted = "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
			#=> 3 days, 3 hours, 15 minutes and 21 seconds
			
			@buycycle_data << {
				"stage" => d.name,
				"total" => d.customer_count,
				"conv_rate" => d.conv_rate,
				"conv_time" => days,		#d.conv_time,
				"data" => []
			}
			
			computer = 0
			phone = 0
			tablet = 0
			@counts = {
				"Computer" => 0,
				"Phone" => 0,
				"Tablet" => 0
			}
			
# 			computers = d.customers.joins(:orders).where("orders.device_type = ?", "Computer").includes(:orders)
# 			computer = computers.all.count
# 			@device_data << {
# 				"stage" => d.name,
# 				"data" => [{ 
# 					"name" => "Computer", 
# 					"count" => 0 
# 				},{
# 					"name" => "Phone",
# 					"count" => 0
# 				},{
# 					"name" => "Tablet",
# 					"count" => 0
# 				}]
# 			}
# 
# 			def getCounts(array, data)
# 				puts array[0]
# 				array.each do |d,i|
# 					string = d["string"]
# 					variable = d["variable"]
# 					data.customers.each do |i|
# 						count = i.orders.any? { |order| order.device_type == string }
# 						if count == true then @counts[string] += 1 end
# 					end
# 					puts @counts["#{string}"]
# 				end
# 			end
			
			devices = ["Computer", "Phone", "Tablet"]
# 			devices << {"string" => "Computer", "variable" => "computer" }
# 			devices << ["Phone", phone]
# 			devices << ["Tablet", tablet]
# 			puts devices[0]
# 			getCounts(devices, d)
			productNames = []
			Product.all.each do |i|
				productNames << i.name
			end
			

			d.customers.each do |i|
				count = i.orders.any? { |order| order.device_type == "Computer" }
				if count == true then computer += 1 end
				count = i.orders.any? { |order| order.device_type == "Phone" }
				if count == true then phone += 1 end
				count = i.orders.any? { |order| order.device_type == "Tablet" }
				if count == true then tablet += 1 end
			end
			@device_data << {
				"stage" => d.name,
				"data" => [{ 
					"name" => "Computer", 
					"count" => computer
				},{
					"name" => "Phone",
					"count" => phone
				},{
					"name" => "Tablet",
					"count" => tablet
				}]
			}
			
			maxValue = [computer, phone, tablet].max
			if maxValue > @largest_dimension then @largest_dimension = maxValue end
			
# 			computer = d.customers.where("orders.device_type = ?", "Computer").count
# 			phone = d.orders.where("device_type = ?", "Phone").count
# 			tablet = d.orders.where("device_type = ?", "Tablet").count
			@product_data << {
				"stage" => d.name,
				"data" => []
			}
# 			productNames.each do |product|
# 				customers = Customer.includes(:order_items => :products).where("order_item.product.name = ?", product)
# 				customersAgain = customers.includes(:orders => :lifecycle_stage).where("order_item.order.lifecycle_stage = ?", d.name)
# 				@product_data[1] << {
# 					"name" => product,
# 					"count" => customersAgain.count
# 				}
# 			end
# 			d.customers.all.each do |i|
		end
		
		BuycycleLifecycle.includes(:lifecycle_stage, :buycycle_stage).each do |i|
			index = i.lifecycle_stage_id - 1
			@buycycle_data[index]["data"] << {
				"name" => i.buycycle_stage.name,
				"count" => i.customer_count
				}
 		end

# 	  getData = []
# 	  getData <<
	  gon.buycycle_data = @buycycle_data.to_json
	  gon.device_data = @device_data.to_json
	  gon.total_customers = @customers.count
	  gon.largest_dimension = @largest_dimension
										 
# 	  gon.noPurchaseAware = BuycycleLifecycle.find(3).customer_count
# 	  gon.noPurchaseInterest = BuycycleLifecycle.find(4).customer_count
# 	  gon.noPurchaseConsider = BuycycleLifecycle.find(5).customer_count
# 	  gon.noPurchaseIntent = BuycycleLifecycle.find(6).customer_count
# 	  gon.onePurchaseRisk = BuycycleLifecycle.find(7).customer_count
# 	  gon.onePurchaseRecent = BuycycleLifecycle.find(8).customer_count
# 	  gon.onePurchaseAware = BuycycleLifecycle.find(9).customer_count
# 	  gon.onePurchaseInterest = BuycycleLifecycle.find(10).customer_count
# 	  gon.onePurchaseConsider = BuycycleLifecycle.find(11).customer_count
# 	  gon.onePurchaseIntent = BuycycleLifecycle.find(12).customer_count
# 	  gon.repeatRisk = BuycycleLifecycle.find(13).customer_count
# 	  gon.repeatRecent = BuycycleLifecycle.find(14).customer_count
#   	  gon.repeatAware = BuycycleLifecycle.find(15).customer_count
# 	  gon.repeatInterest = BuycycleLifecycle.find(16).customer_count
# 	  gon.repeatConsider = BuycycleLifecycle.find(17).customer_count
# 	  gon.repeatIntent = BuycycleLifecycle.find(18).customer_count
# 	  gon.loyalRisk = BuycycleLifecycle.find(19).customer_count
# 	  gon.loyalRecent = BuycycleLifecycle.find(20).customer_count
# 	  gon.loyalAware = BuycycleLifecycle.find(21).customer_count
# 	  gon.loyalInterest = BuycycleLifecycle.find(22).customer_count
# 	  gon.loyalConsider = BuycycleLifecycle.find(23).customer_count
# 	  gon.loyalIntent = BuycycleLifecycle.find(24).customer_count

  end

end
