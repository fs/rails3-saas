class CreateSubscriptionPlans < ActiveRecord::Migration
  def self.up
    create_table :subscription_plans do |t|
      t.string :name
      t.integer :amount
      t.integer :user_limit
      t.integer :renewal_period, :default => 30
      t.integer :trial_period, :default => 30
    end

    def self.down
      drop_table :subscription_plans
    end
  end
end
