class UploadCustomerData < ActiveRecord::Migration
  def change
	jsonfile = File.read("app/assets/javascripts/mockaroo.json")
	customerData = JSON.parse(jsonfile)
	customerData.each do |i|
	     def getTP
	         normal = NormalDistribution.new(10,10)
	         number = normal.rng.round(0)
	         until number > 0 do
	             number = normal.rng.round(0)
	         end
	         return number
	     end
		newCustomer = Customer.new
		newCustomer.name = i["name"]
		newCustomer.email = i["email"]
		newCustomer.city = i["city"]
		newCustomer.state = i["state"]
		newCustomer.country = i["country"]
		newCustomer.total_purchases = getTP
		newCustomer.save
	end
  end
end
