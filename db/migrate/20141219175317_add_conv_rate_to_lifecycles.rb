class AddConvRateToLifecycles < ActiveRecord::Migration
  def up
	  change_table :lifecycle_stages do |t|
		  t.float :conv_rate
	  end

		noPurchase = 4.38
		onePurchase = 2.09
		repeat = 1.76
		loyal = nil

		LifecycleStage.find(1) do |i| i.conv_rate = noPurchase; i.save end
		LifecycleStage.find(2) do |i| i.conv_rate = onePurchase; i.save end
		LifecycleStage.find(3) do |i| i.conv_rate = repeat; i.save end
		LifecycleStage.find(4) do |i| i.conv_rate = loyal; i.save end
  end
  
  def down
	  remove_column :lifecycle_stages, :conv_rate
  end
end
