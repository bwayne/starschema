class HexbinController < ApplicationController
  def index
		@customers = Customer.all
		@orders = Order.all
		@orderItems = OrderItem.all
		
		@hexbinArray = Array.new
		@orderItems.includes(:customer).each do |i|
			if i.customer.revenue > 0 && i.customer.revenue < 500
				@hexbinArray << [i.product_id, 1]
			elsif i.customer.revenue >= 500 && i.customer.revenue < 1000
				@hexbinArray << [i.product_id, 2]
			elsif i.customer.revenue >= 1000 && i.customer.revenue < 1500
				@hexbinArray << [i.product_id, 3]
			elsif i.customer.revenue >= 1500 && i.customer.revenue < 2000
				@hexbinArray << [i.product_id, 4]
			elsif i.customer.revenue >= 2000 && i.customer.revenue < 2500
				@hexbinArray << [i.product_id, 5]
			elsif i.customer.revenue >= 2500 && i.customer.revenue < 3000
				@hexbinArray << [i.product_id, 6]
			elsif i.customer.revenue >= 3000 && i.customer.revenue < 3500
				@hexbinArray << [i.product_id, 7]	
			elsif i.customer.revenue >= 3500 && i.customer.revenue < 4000
				@hexbinArray << [i.product_id, 8]
			elsif i.customer.revenue >= 4000 && i.customer.revenue < 4500
				@hexbinArray << [i.product_id, 9]	
			elsif i.customer.revenue >= 4500 && i.customer.revenue < 5000
				@hexbinArray << [i.product_id, 10]
			elsif i.customer.revenue >= 5000 && i.customer.revenue < 5500
				@hexbinArray << [i.product_id, 11]	
			elsif i.customer.revenue >= 5500 && i.customer.revenue < 6000
				@hexbinArray << [i.product_id, 12]	
			elsif i.customer.revenue >= 6000 && i.customer.revenue < 6500
				@hexbinArray << [i.product_id, 13]	
			elsif i.customer.revenue >= 6500 && i.customer.revenue < 7000
				@hexbinArray << [i.product_id, 14]
			elsif i.customer.revenue >= 7000 && i.customer.revenue < 7500
				@hexbinArray << [i.product_id, 15]	
			elsif i.customer.revenue >= 7500 && i.customer.revenue < 8000
				@hexbinArray << [i.product_id, 16]
			elsif i.customer.revenue >= 8000 && i.customer.revenue < 8500
				@hexbinArray << [i.product_id, 17]	
			elsif i.customer.revenue >= 9000 && i.customer.revenue < 9500
				@hexbinArray << [i.product_id, 18]	
			elsif i.customer.revenue >= 9500 && i.customer.revenue < 10000
				@hexbinArray << [i.product_id, 19]	
			elsif i.customer.revenue >= 10000 && i.customer.revenue < 10500
				@hexbinArray << [i.product_id, 20]	
			end		
		end
		
		
		
		respond_to do |format|
			format.html
			format.json { render :json => @hexbinArray  }
		end
  end
end