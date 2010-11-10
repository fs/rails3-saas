class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table(:subscriptions) do |t|
      t.integer  :account_id
      t.integer  :subscription_plan_id
      t.integer  :cc_number
      t.integer  :cc_cvc
      t.date :cc_valid_thru
      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
