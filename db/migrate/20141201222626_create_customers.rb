class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
	    t.string :name
	    t.string :email
	    t.string :city
	    t.string :state
	    t.string :zip
	    t.string :country

      t.timestamps
    end
  end
end
