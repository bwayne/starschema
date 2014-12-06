class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
	    t.belongs_to :customer
	    t.boolean :mobile
	    t.string :channel
	    t.float :order_total

      t.timestamps
    end
  end
end
