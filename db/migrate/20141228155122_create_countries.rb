class CreateCountries < ActiveRecord::Migration
  def up
    create_table :countries do |t|
	    t.string :name,		:null => false, :unique => true
	    t.integer :customer_count, 	:null => false, :default => 0

      t.timestamps
    end	    
    
    Customer.all.each do |i|
	    country = Country.where("name = ?", i.country)
	    if country.first == nil
		    newCountry = Country.new
		    newCountry.name = i.country
		    newCountry.customer_count = 1
		    newCountry.save
		elsif country.count > 1
			puts "#{country.first.name} has multiple entries"
		else
			Country.increment_counter(:customer_count, country.first.id)
		end
	end
    
  end
  
  def down
	  drop_table :countries
  end
end
