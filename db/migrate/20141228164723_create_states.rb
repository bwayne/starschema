class CreateStates < ActiveRecord::Migration
  def up
    create_table :states do |t|
	    t.string :name,		:null => false, :unique => true
	    t.string :abbr
	    t.integer :customer_count, 	:null => false, :default => 0

      t.timestamps
    end	    



    
    Customer.all.each do |i|
	    state = State.where("name = ?", i.state)
	    if state.first == nil
		    newState = State.new
		    newState.name = i.state
		    newState.customer_count = 1
		    newState.save
		elsif state.count > 1
			puts "#{state.first.name} has multiple entries"
		else
			State.increment_counter(:customer_count, state.first.id)
		end
	end
    
  end
  
  def down
	  drop_table :states
  end
end
