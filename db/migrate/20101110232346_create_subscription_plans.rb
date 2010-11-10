class CreateSubscriptionPlans < ActiveRecord::Migration
  def self.up
    create_table(:subscription_plans) do |t|
      t.string :name
      t.timestamps      
    end
  end

  def self.down
    drop_table :subscription_plans
  end
end
