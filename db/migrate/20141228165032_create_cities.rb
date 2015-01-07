class CreateCities < ActiveRecord::Migration
  def up
    create_table :cities do |t|
	    t.string :name,		:null => false, :unique => true
	    t.belongs_to :state
	    t.integer :customer_count, 	:null => false, :default => 0

      t.timestamps
    end	    
        
	add_column :customers, :country_id, :integer    
    add_column :customers, :state_id, :integer
    add_column :customers, :city_id, :integer    
    
    Customer.all.each do |i|
	    i.state_id = State.where("name = ?", i.state).take.id
	    i.save
	    
	    city = City.where("name = ? AND state_id = ?", i.city, i.state_id)
	    if city != nil
		    newCity = City.new
		    newCity.name = i.city
		    newCity.state_id = i.state_id
		    newCity.customer_count = 1
		    newCity.save
		else
			City.update_counter(:customer_count, city.id)
		end
	end
	
    
  end
  
  def down
	  drop_table :cities
	  remove_column :customers, :country_id
	  remove_column :customers, :state_id
	  remove_column :customers, :city_id
  end
end