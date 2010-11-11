class CreateSubscriptionProfiles < ActiveRecord::Migration
  def self.up
    create_table :subscription_profiles do |t|
      t.integer :subscription_id
      t.string :payment_auth_id
      t.string :card_type
      t.string :card_number
      t.date :card_expired_on
      t.string :card_holder_name

      t.timestamps
    end
  end

  def self.down
    drop_table :subscription_profiles
  end
end
