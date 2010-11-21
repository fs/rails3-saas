class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.integer :account_id
      t.integer :subscription_plan_id
      t.text :last_charge_error
      t.datetime :next_renewal_at
      t.string :plan_name
      t.integer :amount
      t.integer :user_limit
      t.integer :renewal_period, :default => 30
      t.integer :trial_period, :default => 30
      t.string :state, :default => 'trial'
      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
