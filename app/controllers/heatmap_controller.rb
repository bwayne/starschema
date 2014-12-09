class HeatmapController < ApplicationController
  def index
		@customers = Customer.all
		@orders = Order.all
		@orderItems = OrderItem.all
		
		@maxRevenue = Customer.maximum("revenue").round

		@maxRevenue = @maxRevenue + 2000 - (@maxRevenue % 2000)
		@stepper = @maxRevenue / 2000
		
 		@heatmapData = Hash.new
# 		ProductCategory.all.each do |category|
# 			catid = category.id
# 			(@stepper).times do |i|
# 				@heatmapData =  [catid, i, 0]
# 			end
# 		end
#  		@orderItems.includes(:customer).each do |i|
#  			x = 0
#  			arrayFinder = (i.product_category_id - 1) * @stepper
#  			while x < @stepper do
# 	 			if i.customer.revenue > (x * 2000) && i.customer.revenue < ((x * 2000) + 2000)
# 		 			@heatmapData[arrayFinder + x][2] += 1
# 		 		end
# 		 		x += 1
# 	 		end
# 	 	end
# 		
		
		
		
		ProductCategory.includes(:order_items).all.each do |i|
			puts
			puts "#{i.name}:"
			g0_2000 = OrderItem.includes(:customer).where("product_category_id = ? AND customer.revenue >= ? AND customer.revenue < ? ", i.id, 0, 2000).count
			puts "0-2000: #{g0_500}"
			g2000_4000 = OrderItem.includes(:customer).where("product_category_id = ? AND OrderItem.customer.revenue >= ? AND customer.revenue < ? ", i.id, 2000, 4000).count
			puts "2000-4000: #{g2000_4000}"
			g4000_6000 = OrderItem.includes(:customer).where("product_category_id = ? AND OrderItem.customer.revenue >= ? AND customer.revenue < ? ", i.id, 4000, 6000).count
			puts "4000-6000: #{g4000_6000}"
			g6000_8000 = OrderItem.includes(:customer).where("product_category_id = ? AND OrderItem.customer.revenue >= ? AND customer.revenue < ? ", i.id, 6000, 8000).count
			puts "6000-8000: #{g6000_8000}"
			
		end
			
			

# 
# 	 		arrayFinder = (i.product_category_id - 1) * 5
#  			if i.customer.revenue > 0 && i.customer.revenue < 500
# 	 			@heatmapData[arrayFinder + 1][2] +=1
#  			elsif i.customer.revenue >= 500 && i.customer.revenue < 1000
# 	 			@heatmapData[arrayFinder + 2][2] +=1
#  			elsif i.customer.revenue >= 1000 && i.customer.revenue < 1500
# 	 			@heatmapData[arrayFinder + 3][2] +=1
#  			elsif i.customer.revenue >= 1500 && i.customer.revenue < 2000
# 	 			@heatmapData[arrayFinder + 4][2] +=1			
# 	 		end
# 	 	end

		respond_to do |format|
			format.html
			format.json { render :json => @heatmapData  }
		end


		
# 		@orderItems.includes(:customer).each do |i|
# 			if i.customer.revenue > 0 && i.customer.revenue < 500
# 				@hexbinArray[]
# 				
# 				@hexbinArray << [i.product_id, 1]
# 			elsif i.customer.revenue >= 500 && i.customer.revenue < 1000
# 				@hexbinArray << [i.product_id, 2]
# 			elsif i.customer.revenue >= 1000 && i.customer.revenue < 1500
# 				@hexbinArray << [i.product_id, 3]
# 			elsif i.customer.revenue >= 1500 && i.customer.revenue < 2000
# 				@hexbinArray << [i.product_id, 4]
# 			elsif i.customer.revenue >= 2000 && i.customer.revenue < 2500
# 				@hexbinArray << [i.product_id, 5]
# 			elsif i.customer.revenue >= 2500 && i.customer.revenue < 3000
# 				@hexbinArray << [i.product_id, 6]
# 			elsif i.customer.revenue >= 3000 && i.customer.revenue < 3500
# 				@hexbinArray << [i.product_id, 7]	
# 			elsif i.customer.revenue >= 3500 && i.customer.revenue < 4000
# 				@hexbinArray << [i.product_id, 8]
# 			elsif i.customer.revenue >= 4000 && i.customer.revenue < 4500
# 				@hexbinArray << [i.product_id, 9]	
# 			elsif i.customer.revenue >= 4500 && i.customer.revenue < 5000
# 				@hexbinArray << [i.product_id, 10]
# 			elsif i.customer.revenue >= 5000 && i.customer.revenue < 5500
# 				@hexbinArray << [i.product_id, 11]	
# 			elsif i.customer.revenue >= 5500 && i.customer.revenue < 6000
# 				@hexbinArray << [i.product_id, 12]	
# 			elsif i.customer.revenue >= 6000 && i.customer.revenue < 6500
# 				@hexbinArray << [i.product_id, 13]	
# 			elsif i.customer.revenue >= 6500 && i.customer.revenue < 7000
# 				@hexbinArray << [i.product_id, 14]
# 			elsif i.customer.revenue >= 7000 && i.customer.revenue < 7500
# 				@hexbinArray << [i.product_id, 15]	
# 			elsif i.customer.revenue >= 7500 && i.customer.revenue < 8000
# 				@hexbinArray << [i.product_id, 16]
# 			elsif i.customer.revenue >= 8000 && i.customer.revenue < 8500
# 				@hexbinArray << [i.product_id, 17]	
# 			elsif i.customer.revenue >= 9000 && i.customer.revenue < 9500
# 				@hexbinArray << [i.product_id, 18]	
# 			elsif i.customer.revenue >= 9500 && i.customer.revenue < 10000
# 				@hexbinArray << [i.product_id, 19]	
# 			elsif i.customer.revenue >= 10000 && i.customer.revenue < 10500
# 				@hexbinArray << [i.product_id, 20]	
# 			end		
# 		end
    end
end
